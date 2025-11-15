import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.homeImage,
      fit: BoxFit.fill,
      width: double.infinity,
    );
  }
}
