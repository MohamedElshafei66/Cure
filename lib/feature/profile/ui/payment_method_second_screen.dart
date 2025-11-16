import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/payment_service.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class PaymentMethodSecondScreen extends StatefulWidget {
  final String methodName;
  const PaymentMethodSecondScreen({super.key, required this.methodName});

  @override
  State<PaymentMethodSecondScreen> createState() =>
      _PaymentMethodSecondScreenState();
}

class _PaymentMethodSecondScreenState extends State<PaymentMethodSecondScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> cards = [];

  @override
  void initState() {
    super.initState();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    setState(() => isLoading = true);
    final service = PaymentService();
    final response = await service.getAllPaymentMethods(
      methodName: widget.methodName,
    );

    print(" Response From API: $response");

    final data = response["data"];
    if (data is List) {
      setState(() {
        cards = List<Map<String, dynamic>>.from(data);
      });
    } else {
      setState(() => cards = []);
    }

    setState(() => isLoading = false);
  }

  Future<void> _navigateToAddCard(BuildContext context) async {
    final result = await context.push(
      AppRoutes.addCard,
      extra: widget.methodName,
    );
    if (result == "added") {
      fetchPaymentMethods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Payment Method", style: AppStyle.styleRegular24(context)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.noCardImage),
                  Text(
                    "Nothing to display here!",
                    style: AppStyle.styleRegular24(context),
                  ),
                  Text(
                    "Add your cards to make payment easier",
                    style: AppStyle.styleMedium12(context),
                  ),
                  const Gap(200),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ProfileButton(
                      title: "Add ${widget.methodName} Card",

                      onTap: () => _navigateToAddCard(context),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cards.length,
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        return ProfileItem(
                          icon: AppIcons.visa,
                          title:
                              "${card['brand']} ****${card['last3']} (Exp: ${card['expMonth']}/${card['expYear']})",
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  CustomButton(
                    text: "Add Another ${widget.methodName} Card",
                    onPressed: () => _navigateToAddCard(context),
                  ),
                  const Gap(40),
                ],
              ),
            ),
    );
  }
}
