import 'package:dio/dio.dart';

abstract class Exceptions implements Exception {
  final String message;
  const Exceptions(this.message);

  @override
  String toString() => message;
}

class ServerException extends Exceptions {
  const ServerException(super.message);

  factory ServerException.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerException("Connection timeout with api server");
      case DioExceptionType.sendTimeout:
        return const ServerException("Send TimOut timeout with api server");
      case DioExceptionType.receiveTimeout:
        return const ServerException("Receive timeout with api server");
      case DioExceptionType.badCertificate:
        return const ServerException("BadCertificate  with api server");
      case DioExceptionType.badResponse:
        return ServerException.fromResponseError(e.response!.statusCode!,e.response!.data);
      case DioExceptionType.cancel:
        return const ServerException("Request to api server is cancel");
      case DioExceptionType.connectionError:
        return const ServerException("No Internet connection");
      case DioExceptionType.unknown:
        return const ServerException("Oops!There is an error.please try again");
    }
  }


  factory ServerException.fromResponseError(int statusCode , dynamic response){
    if(statusCode == 404){
      return ServerException("Your request is not found. Please try again");
    } else if(statusCode == 500){
      return ServerException("There is a problem in the server. Please try again");
    } else if(statusCode == 400 || statusCode == 401 || statusCode == 403){
      final message = response != null && response['error'] != null
          ? response['error']['message']
          : "Something went wrong";
      return ServerException(message);
    } else {
      return ServerException("Please try again.");
    }
  }
}


class CacheException extends Exceptions {
  const CacheException(super.message);
}


class NetworkException extends Exceptions {
  const NetworkException(super.message);
}

class ValidationException extends Exceptions {
  const ValidationException(super.message);
}
