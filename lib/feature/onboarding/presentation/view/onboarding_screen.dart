import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/data/model/onboarding_model.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/widgets/smooth_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<OnBoardingModel> onboardingData = [
    OnBoardingModel(
      image: AppImages.onboardingFirstImage,
      title: AppStrings.onboarding1Title,
      description: AppStrings.onboarding1Description,
    ),
    OnBoardingModel(
      image: AppImages.onboardingSecondImage,
      title: AppStrings.onboarding2Title,
      description: AppStrings.onboarding2Description,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double r(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    return (value * (width / 375)).clamp(value * 0.8, value * 1.3);
  }

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.push(AppRoutes.sign_in_screen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: r(context, 16),
                  top: r(context, 8),
                ),
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.sign_in_screen),
                  child: Text(
                    AppStrings.skip,
                    style: AppStyle.styleMedium16(context),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                itemCount: onboardingData.length,
                itemBuilder: (_, index) =>
                    OnboardingContent(data: onboardingData[index]),
              ),
            ),
            SizedBox(height: r(context, 24)),
            CustomPageIndicator(
              controller: _pageController,
              count: onboardingData.length,
              responsive: r,
            ),

            SizedBox(height: r(context, 32)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r(context, 24)),
              child: CustomButton(
                text: currentPage == onboardingData.length - 1
                    ? AppStrings.getStarted
                    : AppStrings.next,
                onPressed: nextPage,
              ),
            ),

            SizedBox(height: r(context, 32)),
          ],
        ),
      ),
    );
  }
}
