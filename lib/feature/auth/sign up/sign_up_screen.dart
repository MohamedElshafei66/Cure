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
   final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(60),
      child: CustomAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            SliverToBoxAdapter(child: Image.asset(AppImages.signUpImage,height: 60,width: 60, )),
            SliverToBoxAdapter(child: SizedBox(height: 15)),

            SliverToBoxAdapter(
              child: Text(
                textAlign: TextAlign.center,
                AppStrings.signUpTitle,
                style: AppStyle.styleRegular32( context),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25)),

            SliverToBoxAdapter(
              child: CustomTextFormFeild(
                iconpath: AppIcons.fullName,
                hintText:AppStrings.fullName,
                keyboardType: TextInputType.name,
                validator: (value) {

                },
              ),
            ),
            SliverToBoxAdapter(
              child: CustomTextFormFeild(
                iconpath: AppIcons.email,
                hintText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {

                },
              ),
            ),

            SliverToBoxAdapter(
              child: CustomPhoneField(
                hintText: AppStrings.enterYourNumber,
                controller: phoneController,
                validator: (value) {

                },
              )
              ),


            // SliverToBoxAdapter(
            //   child: CustomTextFormFeild(
            //     iconpath: CupertinoIcons.lock,
            //     hintText: "Password",
            //     keyboardType: TextInputType.visiblePassword,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return "Email is required";
            //       }
            //       return null;
            //     },
            //   ),
            // ),

            SliverToBoxAdapter(child: Center(child: RemmberMe())),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomButton(
                text:AppStrings.signUp,
                onPressed: () => context.go(AppRoutes.otp_screen),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),

            SliverToBoxAdapter(child: CustomOr()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
             SliverToBoxAdapter(
              child: CustomContainer(
                iconPath: AppIcons.google,
                text: AppStrings.signInWithGoogle,
                onTap: () {

                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Center(
                child: CustomTextSpan(
                  text1:AppStrings.alreadyHaveAccount,
                  text2:  AppStrings.signIn,
                  onTap: () => context.go(AppRoutes.sign_in_screen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}