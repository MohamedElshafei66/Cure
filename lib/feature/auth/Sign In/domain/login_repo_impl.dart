import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/data/login_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/models/register_model.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiServices apiServices;

  LoginRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, RegisterModel>> loginUser({required phoneNumber})async {
     try {
      var data = await apiServices.post(
        endPoint: ApiEndpoints.login,
        body: {
         'phoneNumber': phoneNumber,

        },
      );
      return right (RegisterModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromErrorDio(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
