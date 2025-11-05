import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/data/model/onboarding_model.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';

class OnboardingContent extends StatelessWidget {
  final OnBoardingModel data;

  const OnboardingContent({Key? key, required this.data}) : super(key: key);
 double getResponsive(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (size * (screenWidth / 375)).clamp(size * 0.8, size * 1.3);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getResponsive(context, 24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data.image,
            height: size.height * 0.35,
          ),

          SizedBox(height: getResponsive(context, 32)),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: AppStyle.styleRegular24(context)
          ),

          SizedBox(height: getResponsive(context, 16)),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: AppStyle.styleMedium16(context)
          ),
        ],
      ),
    );
  }
}