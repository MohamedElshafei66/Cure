import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/payment_entity.dart';

abstract class PaymentReop{
  Future<Either<Failure,PaymentEntity>> processPaymentMethod(PaymentEntity paymentEntity);
}