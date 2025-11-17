import 'package:dio/dio.dart';
import '../../../core/constants/auth_provider.dart';

class PaymentService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://cure-doctor-booking.runasp.net/api/profile/paymentmethods/";
  final AuthProvider authProvider;

  PaymentService({required this.authProvider});

 
  Future<String?> getToken() async {
    return authProvider.accessToken;
  }

  Future<Map<String, dynamic>> addPaymentMethod({
    required String cardholderName,
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvv,
    required String methodName,
  }) async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        throw Exception("User is not authenticated");
      }

      final last3 = cardNumber.substring(cardNumber.length - 3);

      // Generate a placeholder token from card data
      // In production, this should be obtained from a payment gateway (e.g., Stripe)
      // For now, we create a simple token identifier from card details
      final last4Digits = cardNumber.length >= 4 
          ? cardNumber.substring(cardNumber.length - 4) 
          : cardNumber;
      final expYearStr = expYear.toString();
      final expYearLast2 = expYearStr.length >= 2 
          ? expYearStr.substring(expYearStr.length - 2) 
          : expYearStr.padLeft(2, '0');
      final providerToken = "card_${last4Digits}_${expMonth.toString().padLeft(2, '0')}${expYearLast2}_${DateTime.now().millisecondsSinceEpoch}";

      final body = {
        "methodName": methodName,
        "last3": last3,
        "brand": methodName,
        "expMonth": expMonth,
        "expYear": expYear,
        "providerToken": providerToken, // Placeholder token - should be replaced with actual payment gateway token
        "isEnabled": true,
      };

      print("📤 Sending Payment Data: $body");

      final response = await _dio.post(
        "${_baseUrl}add",
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
          validateStatus: (status) => true, 
        ),
      );

      print("📥 Response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data ??
            {
              "success": true,
              "message": "Payment method added successfully 🎉",
            };
      } else {
        final data = response.data;
        String message = "Failed to add payment method";

        if (data is Map && data.containsKey("errors")) {
          final errors = data["errors"] as Map<String, dynamic>;
          final firstErrorList = errors.values.first;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            message = firstErrorList.first;
          }
        } else if (data is Map && data.containsKey("message")) {
          message = data["message"];
        } else if (data is Map && data.containsKey("title")) {
          message = data["title"];
        }

        return {"success": false, "message": message};
      }
    } on DioException catch (e) {
      print(" DioException: ${e.response?.data}");
      return {
        "success": false,
        "message": e.response?.data?["message"] ??
            "Failed to add payment method (Dio error)",
      };
    } catch (e) {
      print(" General Error: $e");
      return {"success": false, "message": e.toString()};
    }
  }

  /// 🔹 Fetch all payment methods
  Future<Map<String, dynamic>> getAllPaymentMethods({String? methodName}) async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        throw Exception("User is not authenticated");
      }

      String url = "${_baseUrl}getall";
      if (methodName != null && methodName.isNotEmpty) {
        url += "?methodName=$methodName";
      }

      print("📥 Fetching Payment Methods from: $url");

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
          validateStatus: (status) => true,
        ),
      );

      print("📦 Response: ${response.statusCode} - ${response.data}");

      if (response.statusCode == 200 && response.data is Map) {
        final data = response.data;
        return {
          "success": true,
          "data": data["data"] ?? [],
          "message": data["message"] ?? "Success",
        };
      }

      return {
        "success": false,
        "message": "Unexpected response format",
        "data": [],
      };
    } on DioException catch (e) {
      print(" DioException while fetching cards: ${e.response?.data}");
      return {
        "success": false,
        "message":
            e.response?.data?["message"] ?? "Failed to fetch payment methods",
        "data": [],
      };
    } catch (e) {
      print("⚠️ General Error: $e");
      return {"success": false, "message": e.toString(), "data": []};
    }
  }
}

