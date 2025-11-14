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
}
