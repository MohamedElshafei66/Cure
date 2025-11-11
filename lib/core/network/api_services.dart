import 'package:dio/dio.dart';

class ApiServices {
  Dio dio = Dio();
  final baseUrl = 'https://cure-doctor-booking.runasp.net/api/';

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await dio.get('$baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    
    required Map<String, dynamic> body,
  }) async {
    var response = await dio.post('$baseUrl$endPoint', data: body);
    return response.data;
  }
}
