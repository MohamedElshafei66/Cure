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
    final token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception("User is not authenticated");
    }

    final last3 = cardNumber.substring(cardNumber.length - 3);

    final body = {
      "methodName": methodName,
      "last3": last3,
      "brand": "Visa",
      "expMonth": expMonth,
      "expYear": expYear,
      "isEnabled": true,
    };

    final response = await _dio.post(
      "${_baseUrl}add",
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    return response.data ?? {"message": "Your card successfully added 🎉"};
  }


  Future<Map<String, dynamic>> getAllPaymentMethods({
    String? methodName,
    required AuthProvider authProvider, // تمرير الـ authProvider
  }) async {
    try {
      final token = authProvider.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception("User is not authenticated");
      }

      String url = "${_baseUrl}getall";
      if (methodName != null && methodName.isNotEmpty) {
        url += "?methodName=$methodName";
      }

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (response.data is Map && response.data["data"] is List) {
        return {"success": true, "data": response.data["data"]};
      } else {
        return {"success": false, "message": "Unexpected response format", "data": []};
      }
    } on DioException catch (e) {
      return {
        "success": false,
        "message": e.response?.data?["message"] ?? "Failed to fetch payment methods",
        "data": [],
      };
    } catch (e) {
      return {"success": false, "message": e.toString(), "data": []};
    }
  }


}
