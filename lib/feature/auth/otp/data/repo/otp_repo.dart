import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/models/otp_model.dart';

abstract class OtpRepo {
Future<Either<Failure, OtpModel>>verifyRegister({
required String phoneNumber,
required String otpNumber
});

Future<Either<Failure, OtpModel>>verifyLogin({
required String phoneNumber,
required String otpNumber
});

Future<Either<Failure, OtpModel>>resendOtp({
required String phoneNumber,
});
}