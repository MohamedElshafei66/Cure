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
        ) {
   
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final headers = _getHeaders();
          options.headers.addAll(headers);

          print("📤 Sending Request...");
          print("➡️ URL: ${options.uri}");
          print("➡️ Method: ${options.method}");
          print("➡️ Headers: ${options.headers}");
          if (options.data != null) print("➡️ Body: ${options.data}");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("Response Received:");
          print("Status Code: ${response.statusCode}");
          print(" Data: ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) {
          print(" API ERROR:");
          print("URL: ${error.requestOptions.uri}");
          print(" Status Code: ${error.response?.statusCode}");
          print(" Response: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  /// Build headers dynamically using CURRENT Access Token
  Map<String, dynamic> _getHeaders() {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    print(" Current Token: ${authProvider.accessToken}");

    if (authProvider.accessToken != null &&
        authProvider.accessToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${authProvider.accessToken!}';
    } else {
      print(" Access token is missing or empty!");
    }

    return headers;
  }

  // =================== GET ===================
  Future<dynamic> get({required String endPoint}) async {
    try {
      final response = await dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      print(" GET ERROR: ${e.response?.data}");
      rethrow;
    }
  }

  // =================== POST ===================
  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      print(" POST ERROR: ${e.response?.data}");
      rethrow;
    }
  }

  // =================== PUT ===================
  Future<dynamic> put({
    required String endPoint,
    dynamic body,
  }) async {
    try {
      final response = await dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      print("❌ PUT ERROR: ${e.response?.data}");
      rethrow;
    }
  }
}
