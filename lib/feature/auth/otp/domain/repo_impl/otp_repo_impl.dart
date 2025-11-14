import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/models/otp_model.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/repo/otp_repo.dart';

class OtpRepoImpl implements OtpRepo {
  final ApiServices apiServices;

  OtpRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, OtpModel>> resendOtp({
    required String phoneNumber,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.resendOtp,
        body: {'phoneNumber': phoneNumber},
      );
      return right(OtpModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromErrorDio(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OtpModel>> verifyLogin({
    required String phoneNumber,
    required String otpNumber,
  }) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.verifyLogin,
        body: {'phoneNumber': phoneNumber,
        'otpNumber':otpNumber
        },
      );
      return right(OtpModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromErrorDio(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, OtpModel>> verifyRegister({
    required String phoneNumber,
    required String otpNumber,
  }) async{
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.verifyRegister,
        body: {'phoneNumber': phoneNumber,
              'otpNumber':otpNumber
        },
      );
      return right(OtpModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromErrorDio(e));
      }
      return left(ServerFailure(e.toString()));
    }

    }
}
