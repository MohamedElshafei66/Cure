import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_container.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_or.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_text_span.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/default_phone_field.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/presentation/mange/cubit/sign_up_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/presentation/widgets/remmember_me.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignUpCubit>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              children: [
                const SizedBox(height: 15),
                Image.asset(AppImages.signUpImage, height: 60, width: 60),
                const SizedBox(height: 15),
                Text(
                  textAlign: TextAlign.center,
                  AppStrings.signUpTitle,
                  style: AppStyle.styleRegular32(context),
                ),
                const SizedBox(height: 25),

                // full name
                CustomTextFormFeild(
                  controller: cubit.nameController,
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

                // email
                CustomTextFormFeild(
                  controller: cubit.emailController,
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

                // phone
                CustomPhoneField(
                  hintText: AppStrings.enterYourNumber,
                  controller: cubit.phoneController,
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

                const Center(child: RemmberMe()),
                const SizedBox(height: 20),

                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.go(
                        AppRoutes.otp_screen,
                        extra: cubit.phoneController.text,
                      );
                    } else if (state is SignUpError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SignUpLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: AppStrings.signUp,
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.registUser();
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),
                const CustomOr(),
                const SizedBox(height: 20),

                CustomContainer(
                  iconPath: AppIcons.google,
                  text: AppStrings.signInWithGoogle,
                  onTap: () {},
                ),

                const SizedBox(height: 20),
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
