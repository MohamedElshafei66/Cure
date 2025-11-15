
import 'package:round_7_mobile_cure_team3/feature/profile/data/payment_remote_data_source.dart';

class PaymentMethodRepository {
  final PaymentMethodRemoteDataSource remoteDataSource;

  PaymentMethodRepository(this.remoteDataSource);

  Future<String> addPaymentMethod({
    required String methodName,
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvv,
  }) {
    return remoteDataSource.addPaymentMethod(
      methodName: methodName,
      cardNumber: cardNumber,
      expMonth: expMonth,
      expYear: expYear,
      cvv: cvv,
    );
  }
}
