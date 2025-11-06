import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final double Function(BuildContext, double)? responsive;

  const CustomPageIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.responsive,
  }) : super(key: key);
    double defaultResponsive(BuildContext context, double value) {
    final width = MediaQuery.of(context).size.width;
    return (value * (width / 375)).clamp(value * 0.8, value * 1.3);
  }

  @override
  Widget build(BuildContext context) {
    final r = responsive ?? defaultResponsive;

    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.primary,
        dotColor: Colors.grey.shade300,
        dotHeight: r(context, 8),
        dotWidth: r(context, 8),
        spacing: r(context, 8),
        expansionFactor: 3,
      ),
    );
  }
}