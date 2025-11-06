import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/card_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_button.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController cardholderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryMonthController = TextEditingController();
  final TextEditingController expiryYearController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          AppStrings.addNewCardTitle,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Image.asset(AppImages.addCardImage),
              Gap(15),

              Text("Cardholder Name", style: AppStyle.styleMedium16(context)),
              CustomTextField(
                controller: cardholderNameController,
                hintText: "Cardholder Name",
                keyboardType: TextInputType.text,
              ),

              Gap(16),

              Text("Card Number", style: AppStyle.styleMedium16(context)),
              CardTextField(
                controller: cardNumberController,
                hintText: "Enter card number",
              ),

              Gap(16),

              Row(
                children: [
                  Text("Expiry Date", style: AppStyle.styleMedium16(context)),
                  Gap(170),
                  Text("CVV Code", style: AppStyle.styleMedium16(context)),
                ],
              ),
              Gap(6),

              Row(
                children: [
                  // MM & YY Container
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.only(right: 110),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: expiryMonthController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "MM",
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          Container(
                            width: 1,
                            height: 25,
                            color: Colors.grey.shade500,
                          ),
                          Gap(10),
                          Expanded(
                            child: TextField(
                              controller: expiryYearController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "YY",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(12),

                  // CVV Container
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "CVV",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Gap(110),

              ProfileButton(
                title: "      Save",
                showicon: false,
                onTap: () {
                  context.push(AppRoutes.paymentMethodThirdScreen);
                },
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
