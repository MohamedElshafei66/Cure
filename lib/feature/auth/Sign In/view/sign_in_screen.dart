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
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/custom_text_span.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/widgets/default_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Image.asset(
                AppImages.signInImage,
                width: 200,
                height: 200,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: Text(
                textAlign: TextAlign.left,
                AppStrings.enterPhoneNumber,
                style: AppStyle.styleRegular24(context),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: CustomPhoneField(
                hintText: AppStrings.enterYourNumber,
                controller: phoneController,
                validator: (value) {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: CustomButton(
                text: AppStrings.signInWithPhone,
                onPressed: () => context.go(AppRoutes.mainLayout),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(child: CustomOr()),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: CustomContainer(
                iconPath: AppIcons.google,
                text: AppStrings.signInWithGoogle,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25)),

            SliverToBoxAdapter(
              child: Center(
                child: CustomTextSpan(
                  text1: AppStrings.dontHaveAccount,
                  text2: AppStrings.signUp,
                  onTap: () {
                    context.push(AppRoutes.sign_up_screen);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
