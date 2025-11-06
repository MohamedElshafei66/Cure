import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class PaymentMethodThirdScreen extends StatelessWidget {
  const PaymentMethodThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        ),

        title: Text(
          AppStrings.paymentMethod,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileItem(
              icon: AppIcons.visa,
              title: "Axis Bank 450***49",
              icons: AppIcons.circle,
            ),
            Spacer(),
            CustomButton(text: 'Add Card', onPressed: () {}),
            Gap(50),
          ],
        ),
      ),
    );
  }
}
