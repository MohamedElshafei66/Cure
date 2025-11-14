import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/models/register_model.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/repo/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final ApiServices apiServices;

  RegisterRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, RegisterModel>> registerUser({
    required fullName,
    required phoneNumber,
    required email,
  }) async {
    try {
      var data = await apiServices.post(
        endPoint: ApiEndpoints.register,
        body: {
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'Email': email,
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
