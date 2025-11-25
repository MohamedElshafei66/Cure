import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../core/constants/auth_provider.dart';

class PayPalPaymentScreen extends StatefulWidget {
  const PayPalPaymentScreen({super.key});

  @override
  State<PayPalPaymentScreen> createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> cards = [];
  static const String methodName = "PayPal";

  @override
  void initState() {
    super.initState();
    fetchPaymentMethods();
  }

  Future<void> fetchPaymentMethods() async {
    setState(() => isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final service = PaymentService(authProvider: authProvider);

    final response = await service.getAllPaymentMethods(
      methodName: methodName,
    );

    print("Response From API: $response");

    final data = response["data"];
    if (data is List) {
      setState(() {
        cards = List<Map<String, dynamic>>.from(data);
      });
      // Debug: Log method names
      for (var card in cards) {
        print('💳 PayPal - methodName: ${card['methodName']}, brand: ${card['brand']}');
      }
    } else {
      setState(() => cards = []);
    }

    setState(() => isLoading = false);
  }

  Future<void> _navigateToAddCard(BuildContext context) async {
    final result = await context.push(
      AppRoutes.addCard,
      extra: methodName,
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
        leading: InkWell(
          onTap: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        ),
        title: Text("PayPal", style: AppStyle.styleRegular24(context)),
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
                      const Gap(20),
                      Text(
                        "No PayPal cards yet!",
                        style: AppStyle.styleRegular24(context),
                      ),
                      const Gap(8),
                      Text(
                        "Add your PayPal card to make payment easier",
                        style: AppStyle.styleMedium12(context),
                      ),
                      const Gap(200),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ProfileButton(
                          title: "Add PayPal Card",
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
                            // Get method name from card data (methodName or brand)
                            final methodName = card['methodName'] ?? 
                                             card['brand'] ?? 
                                             'PayPal';
                            final last3 = card['last3'] ?? '***';
                            final expMonth = card['expMonth'] ?? '';
                            final expYear = card['expYear'] ?? '';
                            
                            return ProfileItem(
                              icon: AppIcons.payPal,
                              title:
                                  "$methodName ****$last3 (Exp: $expMonth/$expYear)",
                            );
                          },
                        ),
                      ),
                      const Gap(20),
                      CustomButton(
                        text: "Add Another PayPal Card",
                        onPressed: () => _navigateToAddCard(context),
                      ),
                      const Gap(40),
                    ],
                  ),
                ),
    );
  }
}

