import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

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
        title: Text(
          AppStrings.paymentMethod,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Credit / Debit Card", style: AppStyle.styleRegular20(context)),
            const Gap(30),
            ProfileItem(
              icon: AppIcons.visa,
              title: "VISA",
              onTap: () => context.push(
                AppRoutes.paymentMethodSecondScreen,
                extra: "Visa",
              ),
            ),
            const Gap(30),
            ProfileItem(
              icon: AppIcons.masterCaed,
              title: "MasterCard",
              onTap: () => context.push(
                AppRoutes.paymentMethodSecondScreen,
                extra: "MasterCard",
              ),
            ),
            const Gap(20),
            Text("Mobile Wallets", style: AppStyle.styleRegular20(context)),
            const Gap(30),
            ProfileItem(
              icon: AppIcons.applePay,
              title: "Apple Pay",
              onTap: () => context.push(
                AppRoutes.paymentMethodSecondScreen,
                extra: "ApplePay",
              ),
            ),
            const Gap(30),
            ProfileItem(
              icon: AppIcons.payPal,
              title: "PayPal",
              onTap: () => context.push(
                AppRoutes.paymentMethodSecondScreen,
                extra: "PayPal",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
