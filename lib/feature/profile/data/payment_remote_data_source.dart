import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';

class PaymentMethodRemoteDataSource {
  final ApiServices api;

  PaymentMethodRemoteDataSource(this.api);

  Future<String> addPaymentMethod({
    required String methodName,
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvv,
  }) async {
<<<<<<< HEAD
    // final token = await api.getToken();
=======
    //final token = await api.getToken();
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab

    final last3 = cardNumber.substring(cardNumber.length - 3);

    final data = {
      "methodName": methodName,
      "last3": last3,
      "brand": "Visa",
      "expMonth": expMonth,
      "expYear": 2000 + expYear,
      "isEnabled": true,
    };

    final response = await api.dio.post(
      '${api.baseUrl}profile/paymentmethods/add',
      data: data,
<<<<<<< HEAD
=======
      options: Options(
        headers: {
         // 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
    );

    return response.data["message"] ?? "Your card successfully added 🎉";
  }
}
