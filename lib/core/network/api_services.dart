import 'package:dio/dio.dart';
import '../constants/auth_provider.dart';

class ApiServices {
  final Dio dio;
  final AuthProvider authProvider;

  ApiServices({required this.authProvider})
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://cure-doctor-booking.runasp.net/api/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  /// Build headers dynamically using CURRENT Access Token
  Map<String, dynamic> _getHeaders() {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (authProvider.accessToken != null) {
      headers['Authorization'] =
      'Bearer ${authProvider.accessToken!}';
    }

    return headers;
  }

  Future<dynamic> get({required String endPoint}) async {
    try {
      final headers = _getHeaders();

      final response = await dio.get(
        endPoint,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      print("GET ERROR: ${e.response?.data}");
      rethrow;
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final headers = _getHeaders();

      final response = await dio.post(
        endPoint,
        data: body,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      print("POST ERROR: ${e.response?.data}");
      rethrow;
    }
  }

  Future<dynamic> put({
    required String endPoint,
    dynamic body,
  }) async {
    try {
      final headers = _getHeaders();

      final response = await dio.put(
        endPoint,
        data: body,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      print("PUT ERROR: ${e.response?.data}");
      rethrow;
    }
  }
}
