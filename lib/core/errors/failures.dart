import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure{
  const ServerFailure(super.error);

  factory ServerFailure.fromErrorDio(DioException e){
    switch(e.type){
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with api server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("send TimOut timeout with api server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receive timeout with api server");
      case DioExceptionType.badCertificate:
        return ServerFailure("badCertificate  with api server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponseError(e.response!.statusCode!,e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request to api server is cancel");
      case DioExceptionType.connectionError:
        return ServerFailure("No internet Connection");
      case DioExceptionType.unknown:
        return ServerFailure("Oops!There is an error.please try again");
    }
  }

  factory ServerFailure.fromResponseError(int statusCode , dynamic response){
    if(statusCode == 404){
      return ServerFailure("Your request is not found. Please try again");
    } else if(statusCode == 500){
      return ServerFailure("There is a problem in the server. Please try again");
    } else if(statusCode == 400 || statusCode == 401 || statusCode == 403){
      final message = response != null && response['error'] != null
          ? response['error']['message']
          : "Something went wrong";
      return ServerFailure(message);
    } else {
      return ServerFailure("Please try again.");
    }
  }

}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
