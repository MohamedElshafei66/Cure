import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/models/register_model.dart';

abstract class LoginRepo {
  Future<Either<Failure,RegisterModel>>loginUser({
    required phoneNumber,
  });
}