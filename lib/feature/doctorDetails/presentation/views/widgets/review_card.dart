import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entites/doctor_details_entity.dart';

class ReviewCard extends StatelessWidget {
  final DoctorDetailsEntity doctorDetails;
  const ReviewCard({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    // For now, show a placeholder review. You can extend this to show actual reviews from the API
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1550831107-1553da8c8464',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nabila Reyna",
                      style: AppStyle.styleRegular16(context).copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "30 min ago",
                      style: AppStyle.styleMedium14(context).copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    SvgImage(
                      AppImages.ratingStarImage,
                      type: PathType.assets,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      doctorDetails.rating.toStringAsFixed(1),
                      style: AppStyle.styleMedium14(context).copyWith(
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            AppStrings.reviewText,
            style: AppStyle.styleMedium14(context).copyWith(
              color: AppColors.whiteColor79,
            ),
          ),
        ],
      ),
    );
  }
}
