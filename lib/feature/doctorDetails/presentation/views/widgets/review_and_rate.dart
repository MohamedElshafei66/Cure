import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class ReviewAndRate extends StatelessWidget {
  const ReviewAndRate({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children:[
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children:[
              Text(
                  AppStrings.reviewsAndRatingTitle,
                  style:AppStyle.styleRegular20(context).copyWith(
                      fontWeight:FontWeight.w500,
                      color:AppColors.blackColor
                  )
              ),
              InkWell(
                onTap:(){},
                child: Row(
                  children:[
                    SvgImage(
                        AppImages.penImage,
                        type:PathType.assets
                    ),
                    SizedBox(
                      width:5,
                    ),
                    Text(
                        AppStrings.addReview,
                        style:AppStyle.styleRegular14(context).copyWith(
                            fontWeight:FontWeight.w500,
                            color:AppColors.primary
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
              height: 8
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  AppStrings.averageRatingLabel,
                  style:AppStyle.styleRegular40(context)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Row(
                    children: [
                      SvgImage(
                          AppImages.ratingStarImage,
                          type:PathType.assets
                      ),
                      SvgImage(
                          AppImages.ratingStarImage,
                          type:PathType.assets
                      ),
                      SvgImage(
                          AppImages.ratingStarImage,
                          type:PathType.assets
                      ),
                      SvgImage(
                          AppImages.ratingStarImage,
                          type:PathType.assets
                      ),
                      SvgImage(
                          AppImages.ratingStarImage,
                          type:PathType.assets
                      )
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "1250+ Reviews",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
