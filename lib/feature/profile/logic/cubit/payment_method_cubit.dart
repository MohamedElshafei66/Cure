import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/payment_method_repository.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  final PaymentMethodRepository repository;

  PaymentMethodCubit(this.repository) : super(PaymentMethodInitial());

  Future<void> addPaymentMethod({
    required String methodName,
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvv,
  }) async {
    emit(PaymentMethodLoading());
    try {
      final message = await repository.addPaymentMethod(
        methodName: methodName,
        cardNumber: cardNumber,
        expMonth: expMonth,
        expYear: expYear,
        cvv: cvv,
      );
      emit(PaymentMethodSuccess(message));
    } catch (e) {
      emit(PaymentMethodError(e.toString()));
    }
  }
}
