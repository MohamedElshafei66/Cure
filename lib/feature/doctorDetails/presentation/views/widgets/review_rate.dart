import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class ReviewRate extends StatelessWidget {
  const ReviewRate({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImage(
          AppImages.ratingStarImage,
          type:PathType.assets,
          height:30,
        ),
        SvgImage(
          AppImages.ratingStarImage,
          type:PathType.assets,
          height:30,
        ),
        SvgImage(
          AppImages.ratingStarImage,
          type:PathType.assets,
          height:30,
        ),
        SvgImage(
          AppImages.ratingStarImage,
          type:PathType.assets,
          height:30,
        ),
        SvgImage(
          AppImages.ratingStarImage,
          type:PathType.assets,
          height:30,
        ),
        Spacer(),
        Text(
            AppStrings.averageRatingLabel,
            style:AppStyle.styleRegular40(context)
        ),
      ],
    );
  }
}
