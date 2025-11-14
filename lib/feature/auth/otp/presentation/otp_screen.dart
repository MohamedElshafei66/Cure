import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/widgets/custom_or.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/mange/cubit/otp_cubit.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isRegister;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.isRegister = true,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late OtpCubit otpCubit;
  int secondsRemaining = 55;
  Timer? timer;
  bool isExpired = false;

  @override
  void initState() {
    super.initState();
    otpCubit = BlocProvider.of<OtpCubit>(context);
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          isExpired = true;
        });
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    otpCubit.disposeControllers();
    timer?.cancel();
    super.dispose();
  }

  void verifyCode() {
    String otp = otpCubit.otpControllers.map((c) => c.text).join();

    if (widget.isRegister) {
      otpCubit.verifyRegister(phoneNumber: widget.phoneNumber, otp: otp);
    } else {
      otpCubit.verifyLogin(phoneNumber: widget.phoneNumber, otp: otp);
    }
  }

  void resendOtp() {
    if (!isExpired) return;

    otpCubit.resendOtp(phoneNumber: widget.phoneNumber);
    setState(() {
      secondsRemaining = 55;
      isExpired = false;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(AppIcons.arrowLeft, height: 24, width: 24),
        ),
        title: Text(
          AppStrings.otpTitle,
          style: AppStyle.styleRegular20(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              AppStrings.otpDescription(widget.phoneNumber),
              textAlign: TextAlign.center,
              style: AppStyle.styleRegularMon16(context),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: otpCubit.otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      fillColor: AppColors.lightGrey,
                      filled: true,
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              isExpired
                  ? AppStrings.wrongCode
                  : "Resend in $secondsRemaining s",
              style: isExpired
                  ? AppStyle.styleRegular14(context).copyWith(color: Colors.red)
                  : AppStyle.styleRegular14(context),
            ),
            if (isExpired)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: resendOtp,
                    child: Text(
                      "Resend",
                      style: AppStyle.styleMedium14(
                        context,
                      ).copyWith(color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      context.go(AppRoutes.sign_in_screen);
                    },
                    child: Text(
                      "Enter another phone number",
                      style: AppStyle.styleMedium14(
                        context,
                      ).copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 40),
            BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is OtpSuccess && state.isResend == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.otpMessage ?? "OTP Verified!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.go(AppRoutes.home);
                } else if (state is OtpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is OtpSuccess && state.isResend) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.otpMessage ?? "OTP Resent!"),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is OtpLoading) {
                  return const CircularProgressIndicator();
                }
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: AppStrings.verify,
                    onPressed: verifyCode,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
