import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';

class PaymentService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://cure-doctor-booking.runasp.net/api/profile/paymentmethods/";
  final SecureStorageService? secureStorage;

<<<<<<< HEAD
  PaymentService({this.secureStorage});
=======
  final String _testToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4ODA4Y2YwNS0zYTI1LTRjOTUtODBlMi1kNTI2MDJlM2FmNDgiLCJ1bmlxdWVfbmFtZSI6IiswMTA5MDE1OTAxNiIsImZpcnN0TmFtZSI6Ik1pbmEiLCJsYXN0TmFtZSI6IlJvbWEiLCJhZGRyZXNzIjoiIiwiaW1nVXJsIjoiIiwiYmlydGhEYXRlIjoiMDAwMS0wMS0wMSIsImdlbmRlciI6Ik1hbGUiLCJsb2NhdGlvbiI6IiIsImlzTm90aWZpY2F0aW9uc0VuYWJsZWQiOiJUcnVlIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI4ODA4Y2YwNS0zYTI1LTRjOTUtODBlMi1kNTI2MDJlM2FmNDgiLCJleHAiOjE3NjMzMzgxMDYsImlzcyI6Imh0dHBzOi8vY3VyZS1kb2N0b3ItYm9va2luZy5ydW5hc3AubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDAsaHR0cHM6Ly9sb2NhbGhvc3Q6NTUwMCxodHRwczovL2xvY2FsaG9zdDo0MjAwICxodHRwczovL2N1cmUtZG9jdG9yLWJvb2tpbmcucnVuYXNwLm5ldC8ifQ.JTtiIO0T9oYFf2xwSt2q1dwaQOZ1gEBXqGB2GoLHA1c";
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab

  Future<String?> getToken() async {
    if (secureStorage != null) {
      return await secureStorage!.read(key: 'accessToken');
    }
    return null;
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
        return {
          "success": false,
          "message": "Authentication token not available",
        };
      }
      final last3 = cardNumber.substring(cardNumber.length - 3);

      final body = {
        "methodName": methodName,
        "last3": last3,
        "brand": methodName,
        "expMonth": expMonth,
        "expYear": expYear,
        "isEnabled": true,
        "providerToken": "test_provider_token_123", 
      };

      print(" Sending Payment Data: $body");

      final response = await _dio.post(
        "${_baseUrl}add",
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      print("Raw Response Type: ${response.data.runtimeType}");
      print(" Raw Response: ${response.data}");

      if (response.data == null || response.data.toString().trim().isEmpty) {
        return {
          "success": true,
          "message": "Payment method added successfully (empty response)",
        };
      }

      if (response.data is Map<String, dynamic>) {
        return response.data;
      }

      return {"success": true, "message": "Payment added successfully"};
    } on DioException catch (e) {
      print(" DioException while adding payment: ${e.response?.data}");
      return {
        "success": false,
        "message":
            e.response?.data?['message'] ?? "Failed to add payment method",
      };
    } catch (e) {
      print(" General Error: $e");
      return {"success": false, "message": e.toString()};
    }
  }
  Future<Map<String, dynamic>> getAllPaymentMethods({
    String? methodName,
  }) async {
    try {
      final token = await getToken();
      if (token == null || token.isEmpty) {
        return {
          "success": false,
          "message": "Authentication token not available",
        };
      }
      String url = "${_baseUrl}getall";
      if (methodName != null && methodName.isNotEmpty) {
        url += "?methodName=$methodName";
      }

      print(" Fetching Payment Methods from: $url");

      final response = await _dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.data is Map && response.data["data"] is List) {
        return {"success": true, "data": response.data["data"]};
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
      print(" General Error: $e");
      return {"success": false, "message": e.toString(), "data": []};
    }
  }
}
