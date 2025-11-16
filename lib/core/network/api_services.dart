import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio;

  final String baseUrl = 'https://cure-doctor-booking.runasp.net/api/';

  final String? token;

  ApiServices({this.token})
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://cure-doctor-booking.runasp.net/api/',

      headers: {
        'Accept': 'application/json',

        if (token != null) 'Authorization': 'Bearer $token',
      },
    ),
  );

  Future<dynamic> get({required String endPoint}) async {
    try {
      final response = await dio.get(endPoint);

      return response.data;
    } on DioException catch (e) {
      throw Exception('GET $endPoint failed: ${e.response?.data ?? e.message}');
    }
  }

  Future<dynamic> post({
    required String endPoint,

    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await dio.post(endPoint, data: body);

      return response.data;
    } on DioException catch (e) {
      throw Exception(
        'POST $endPoint failed: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<dynamic> put({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw Exception('PUT $endPoint failed: ${e.response?.data ?? e.message}');
    }
  }
}
//class ApiServices {
// Dio dio = Dio();
//final String baseUrl = 'https://cure-doctor-booking.runasp.net/api/';

//final String testToken =
//  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4ODA4Y2YwNS0zYTI1LTRjOTUtODBlMi1kNTI2MDJlM2FmNDgiLCJ1bmlxdWVfbmFtZSI6IiswMTA5MDE1OTAxNiIsImZpcnN0TmFtZSI6Ik1pbmEiLCJsYXN0TmFtZSI6IlJvbWEiLCJhZGRyZXNzIjoiIiwiaW1nVXJsIjoiIiwiYmlydGhEYXRlIjoiMDAwMS0wMS0wMSIsImdlbmRlciI6Ik1hbGUiLCJsb2NhdGlvbiI6IiIsImlzTm90aWZpY2F0aW9uc0VuYWJsZWQiOiJUcnVlIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI4ODA4Y2YwNS0zYTI1LTRjOTUtODBlMi1kNTI2MDJlM2FmNDgiLCJleHAiOjE3NjMzMzgxMDYsImlzcyI6Imh0dHBzOi8vY3VyZS1kb2N0b3ItYm9va2luZy5ydW5hc3AubmV0LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDAsaHR0cHM6Ly9sb2NhbGhvc3Q6NTUwMCxodHRwczovL2xvY2FsaG9zdDo0MjAwICxodHRwczovL2N1cmUtZG9jdG9yLWJvb2tpbmcucnVuYXNwLm5ldC8ifQ.JTtiIO0T9oYFf2xwSt2q1dwaQOZ1gEBXqGB2GoLHA1c";

//Future<String> getToken() async {
//final prefs = await SharedPreferences.getInstance();
//final token = prefs.getString('token');
//if (token != null && token.isNotEmpty) {
//  return token;
//}

// return testToken;
// }

//  Future<Map<String, dynamic>> get({
// required String endPoint,
// bool withToken = false,
//}) async {
//  Options? options;
/// if (withToken) {
// final token = await getToken();
// options = Options(
///  headers: {
// 'Authorization': 'Bearer $token',
//  'Accept': 'application/json',
//},
// );
// }
// final response = await dio.get('$baseUrl$endPoint', options: options);
//     return response.data;
//   }

//   Future<Map<String, dynamic>> put({
//     required String endPoint,
//     required dynamic data,
//     bool withToken = false,
//   }) async {
//     Options? options;
//     if (withToken) {
//       final token = await getToken();
//       options = Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );
//     }

//     final response = await dio.put(
//       '$baseUrl$endPoint',
//       data: data,
//       options: options,
//     );
//     return response.data;
//   }
// }