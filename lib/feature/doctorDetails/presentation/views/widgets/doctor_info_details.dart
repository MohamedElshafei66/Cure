import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class DoctorInfoDetails extends StatelessWidget {
  const DoctorInfoDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Expanded(
              child: StateItem(
                image: AppImages.patiantsImage,
                label: "2,000+",
                sub: AppStrings.patientsLabel,
              )),
          Expanded(
              child: StateItem(
                image: AppImages.experienceImage,
                label: "10+",
                sub: AppStrings.experienceLabel,
              )),
          Expanded(
              child: StateItem(
                image: AppImages.starImage,
                label: "4.5",
                sub: AppStrings.ratingLabel,
              )),
          Expanded(
              child: StateItem(
                image: AppImages.reviewsImage,
                label: "1,872",
                sub: AppStrings.reviewsLabel,
              )),
        ],
      ),
    );
  }
}



class StateItem extends StatelessWidget {
  final String  image;
  final String label;
  final String sub;

  const StateItem({super.key,
    required this.image,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgImage(
            image,
            type:PathType.assets
        ),
        const SizedBox(
            height: 6
        ),
        Text(
            label,
            style:AppStyle.styleMedium16(context).copyWith(
                fontWeight:FontWeight.w800,
                color:AppColors.greyColor
            )
        ),
        const SizedBox(
            height: 2
        ),
        Text(
            sub,
            style:AppStyle.styleMedium14(context).copyWith(
                color:AppColors.whiteColor79
            )
        )
      ],
    );
  }
}
