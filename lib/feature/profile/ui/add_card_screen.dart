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
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController cardholderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryMonthController = TextEditingController();
  final TextEditingController expiryYearController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardholderNameController.dispose();
    cardNumberController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.addNewCardTitle,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.addCardImage),
                const Gap(20),

                /// Cardholder Name
                Text("Cardholder Name", style: AppStyle.styleMedium16(context)),
                CustomTextField(
                  controller: cardholderNameController,
                  hintText: "Enter Cardholder Name",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cardholder name is required";
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return "Only English letters allowed";
                    }
                    return null;
                  },
                ),
                const Gap(20),

                /// Card Number
                Text("Card Number", style: AppStyle.styleMedium16(context)),
                CardTextField(
                  controller: cardNumberController,
                  hintText: "Enter Card Number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Card number is required";
                    }
                    final digits = value.replaceAll(' ', '');
                    if (digits.length != 16 || int.tryParse(digits) == null) {
                      return "Please enter your card number";
                    } else if (value.length != 16) {
                      return 'Card number must be 16 digits';
                    }
                    return null;
                  },
                ),
                const Gap(20),

                /// Expiry + CVV
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expiry Date", style: AppStyle.styleMedium16(context)),
                    Text("CVV Code", style: AppStyle.styleMedium16(context)),
                  ],
                ),
                const Gap(8),

                Row(
                  children: [
                    /// Expiry (MM/YY)
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: expiryMonthController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "MM",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required";
                                  }
                                  final month = int.tryParse(value);
                                  if (month == null ||
                                      month < 1 ||
                                      month > 12) {
                                    return "Invalid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey.shade500,
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextFormField(
                                controller: expiryYearController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "YY",
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required";
                                  }
                                  final year = int.tryParse(value);
                                  if (year == null || year < 25 || year > 35) {
                                    return "Invalid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12),

                    /// CVV
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "CVV",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            if (value.length != 3) {
                              return "3 digits only";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(100),

                /// Save Button
                ProfileButton(
                  title: "    Save",
                  showicon: false,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.push(AppRoutes.paymentMethodThirdScreen);
                    }
                  },
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
