import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/payment_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/payment_repo.dart';

class PaymentUseCase extends UseCase<PaymentEntity,PaymentEntity>{
  final PaymentReop paymentReop;
  PaymentUseCase(this.paymentReop);

  @override
  Future<Either<Failure, PaymentEntity>> call(PaymentEntity paymentEntity)async{
    return await paymentReop.processPaymentMethod(paymentEntity);
  }

}