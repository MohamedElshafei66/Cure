import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/mange/cubit/sign_in_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_container.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_or.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_text_span.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/default_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignInCubit>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.signInImage,
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 25),

                Text(
                  AppStrings.enterPhoneNumber,
                  style: AppStyle.styleRegular24(context),
                ),
                const SizedBox(height: 25),

                CustomPhoneField(
                  hintText: AppStrings.enterYourNumber,
                  controller: cubit.phoneController,
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
                const SizedBox(height: 25),

                BlocConsumer<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is SignInSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login successful ✅"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        context.go(
                          AppRoutes.otp_screen,
                          extra: cubit.phoneController.text,
                        );
                      });
                    } else if (state is SignInError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SignInLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return CustomButton(
                      text: AppStrings.signInWithPhone,
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.logUser();
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 15),
                const CustomOr(),
                const SizedBox(height: 15),

                CustomContainer(
                  iconPath: AppIcons.google,
                  text: AppStrings.signInWithGoogle,
                  onTap: () {},
                ),

                const SizedBox(height: 25),

                Center(
                  child: CustomTextSpan(
                    text1: AppStrings.dontHaveAccount,
                    text2: AppStrings.signUp,
                    onTap: () => context.go(AppRoutes.sign_up_screen),
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
