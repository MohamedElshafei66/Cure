import 'dart:async';
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class ResendCodeText extends StatefulWidget {
  final VoidCallback? onTap;

  const ResendCodeText({super.key, this.onTap});

  @override
  State<ResendCodeText> createState() => _ResendCodeTextState();
}

class _ResendCodeTextState extends State<ResendCodeText> {
  int secondsRemaining = 55;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: RichText(
        text: TextSpan(
          style: AppStyle.styleMedium14(context)
              .copyWith(color: AppColors.textPrimary),
          children: [
            const TextSpan(text: AppStrings.resendCode),
            TextSpan(
              text: " $secondsRemaining s",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}