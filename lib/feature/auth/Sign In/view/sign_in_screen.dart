import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_container.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_or.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_text_span.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/default_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                AppImages.signInImage,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 25),
              Text(
                textAlign: TextAlign.left,
                AppStrings.enterPhoneNumber,
                style: AppStyle.styleRegular24(context),
              ),
              SizedBox(height: 25),
              CustomPhoneField(
                hintText: AppStrings.enterYourNumber,
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Only numbers are allowed';
                  }
                  if (value.length < 10) {
                    return 'Phone number must be at least 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              CustomButton(
                text: AppStrings.signInWithPhone,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.go(AppRoutes.notification_screen);
                  }
                },
              ),
              SizedBox(height: 15),
              CustomOr(),
              SizedBox(height: 15),
              CustomContainer(
                iconPath: AppIcons.google,
                text: AppStrings.signInWithGoogle,
                onTap: () {},
              ),
              SizedBox(height: 25),
              Center(
                child: CustomTextSpan(
                  text1: AppStrings.dontHaveAccount,
                  text2: AppStrings.signUp,
                  onTap: () {
                    context.go(AppRoutes.sign_up_screen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}