import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/models/register_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure,RegisterModel>> registerUser({
    required fullName,
    required phoneNumber,
    required email,
  });
}
