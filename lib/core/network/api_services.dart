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
      print('Making GET request to: $endPoint');
      print('Full URL: ${dio.options.baseUrl}$endPoint');
      print('Headers: ${dio.options.headers}');
      
      final response = await dio.get(endPoint);
      
      print('Response status: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');
      
      return response.data;
    } on DioException catch (e) {
      print('DioException in ApiServices:');
      print('Type: ${e.type}');
      print('Message: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      rethrow; // Re-throw to be caught by data source
    } catch (e) {
      print('Exception in ApiServices: $e');
      rethrow;
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      print('========================================');
      print('API SERVICES: POST REQUEST');
      print('========================================');
      print('Full URL: ${dio.options.baseUrl}$endPoint');
      print('Headers: ${dio.options.headers}');
      print('Request Body:');
      body.forEach((key, value) {
        print('  $key: $value (${value.runtimeType})');
      });
      print('========================================');
      
      final response = await dio.post(endPoint, data: body);
      
      print('========================================');
      print('API SERVICES: POST RESPONSE');
      print('========================================');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('Response Type: ${response.data.runtimeType}');
      print('========================================');
      
      return response.data;
    } on DioException catch (e) {
      print('========================================');
      print('API SERVICES: POST ERROR');
      print('========================================');
      print('Error Type: ${e.type}');
      print('Error Message: ${e.message}');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('========================================');
      throw Exception(
        'POST $endPoint failed: ${e.response?.data ?? e.message}',
 );
}
}
}
