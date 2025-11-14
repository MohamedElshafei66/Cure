import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entites/doctor_details_entity.dart';
import '../../cubit/doctor_details_cubit.dart';

class ReviewAndRate extends StatelessWidget {
  final DoctorDetailsEntity doctorDetails;
  const ReviewAndRate({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.reviewsAndRatingTitle,
                style: AppStyle.styleRegular20(context).copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              InkWell(
                onTap: () async {
                  final result = await context.push<bool>(
                    AppRoutes.addReviewScreen,
                    extra: doctorDetails.doctorId,
                  );

                  if (result == true) {
                    final doctorDetailsCubit = context.read<DoctorDetailsCubit>();
                    doctorDetailsCubit.fetchDoctorDetails(doctorDetails.doctorId);
                  }
                },
                child: Row(
                  children: [
                    SvgImage(
                      AppImages.penImage,
                      type: PathType.assets,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      AppStrings.addReview,
                      style: AppStyle.styleRegular14(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doctorDetails.rating.toStringAsFixed(1),
                style: AppStyle.styleRegular40(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => SvgImage(
                        AppImages.ratingStarImage,
                        type: PathType.assets,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${doctorDetails.reviews.toInt()}+ Reviews",
                    style: const TextStyle(color: Colors.grey),
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
