import 'package:dio/dio.dart';
import '../constants/shared_data.dart';

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
        'Content-Type': 'application/json',

        if (token != null) 'Authorization': 'Bearer $token',
      },
    ),
  );



  // Get headers with current token dynamically
  Map<String, dynamic> _getHeaders() {
    final headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    
    final token = SharedData.token;
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }

  Future<dynamic> get({required String endPoint}) async {
    try {
      final headers = _getHeaders();
      print('Making GET request to: $endPoint');
      print('Full URL: ${dio.options.baseUrl}$endPoint');
      print('Headers: $headers');
      
      final response = await dio.get(
        endPoint,
        options: Options(headers: headers),
      );
      
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

      final response = await dio.post(endPoint, data: body);

      return response.data;
    } on DioException catch (e) {

      final headers = _getHeaders();
      print('========================================');
      print('API SERVICES: POST REQUEST');
      print('========================================');
      print('Full URL: ${dio.options.baseUrl}$endPoint');
      print('Headers: $headers');
      print('Request Body:');
      body.forEach((key, value) {
        print('  $key: $value (${value.runtimeType})');
      });
      print('========================================');
      
      final response = await dio.post(
        endPoint,
        data: body,
        options: Options(headers: headers),
      );
      
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
      print('Request Headers: ${e.requestOptions.headers}');
      print('========================================');
      
      // Provide more specific error message for 401
      if (e.response?.statusCode == 401) {
        throw Exception(
          'Authentication failed. Please check if your token is valid and not expired. POST $endPoint failed: ${e.response?.data ?? e.message}',
        );
      }
      

      throw Exception(
        'POST $endPoint failed: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<dynamic> put({
    required String endPoint,

    dynamic body,
  })async {
    try {
      final headers = _getHeaders();
      print('========================================');
      print('API SERVICES: PUT REQUEST');
      print('========================================');
      print('Full URL: ${dio.options.baseUrl}$endPoint');
      print('Headers: $headers');
      if (body != null) {
        print('Request Body:');
        if (body is Map) {
          body.forEach((key, value) {
            print('  $key: $value (${value.runtimeType})');
          });
        } else {
          print('  $body (${body.runtimeType})');
        }
      }
      print('========================================');
      
      final response = await dio.put(
        endPoint,
        data: body,
        options: Options(headers: headers),
      );
      
      print('========================================');
      print('API SERVICES: PUT RESPONSE');
      print('========================================');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('Response Type: ${response.data.runtimeType}');
      print('========================================');
      
      return response.data;
    } on DioException catch (e) {
      print('========================================');
      print('API SERVICES: PUT ERROR');
      print('========================================');
      print('Error Type: ${e.type}');
      print('Error Message: ${e.message}');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Request Headers: ${e.requestOptions.headers}');
      print('========================================');
      
      // Provide more specific error message for 401
      if (e.response?.statusCode == 401) {
        throw Exception(
          'Authentication failed. Please check if your token is valid and not expired. PUT $endPoint failed: ${e.response?.data ?? e.message}',
        );
      }
      
      throw Exception(
        'PUT $endPoint failed: ${e.response?.data ?? e.message}',
      );

    }
  }
}
