import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
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
import 'package:round_7_mobile_cure_team3/feature/auth/widgets/remmember_me.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                Image.asset(AppImages.signUpImage, height: 60, width: 60),
                SizedBox(height: 15),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.signUpTitle,
                  style: AppStyle.styleRegular32(context),
                ),
                SizedBox(height: 25),
                CustomTextFormFeild(
                  iconpath: AppIcons.fullName,
                  hintText: AppStrings.fullName,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Name can only contain letters';
                    }
                    return null;
                  },
                ),
                CustomTextFormFeild(
                  iconpath: AppIcons.email,
                  hintText: AppStrings.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                CustomPhoneField(
                  hintText: AppStrings.enterYourNumber,
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10,11}$').hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                Center(child: RemmberMe()),
                SizedBox(height: 20),
                CustomButton(
                  text: AppStrings.signUp,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.go(AppRoutes.otp_screen);
                    }
                  },
                ),
                SizedBox(height: 20),
                CustomOr(),
                SizedBox(height: 20),
                CustomContainer(
                  iconPath: AppIcons.google,
                  text: AppStrings.signInWithGoogle,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomTextSpan(
                    text1: AppStrings.alreadyHaveAccount,
                    text2: AppStrings.signIn,
                    onTap: () => context.go(AppRoutes.sign_in_screen),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
