import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class FavouritesEmptyView extends StatelessWidget {
  const FavouritesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.yourFavDoctorsImage),
        const SizedBox(height: 12),
        Text(
          'No favorite doctors yet',
          style: AppStyle.styleRegular20(context),
        ),
        const SizedBox(height: 8),
        Text(
          'Add your favorite doctors to find them easily',
          style: AppStyle.styleMedium12(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

