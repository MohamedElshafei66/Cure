import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entites/doctor_details_entity.dart';
import '../../../data/models/doctor_detail_model.dart';
import '../../../data/models/doctor_review_model.dart';

class ReviewCard extends StatelessWidget {
  final DoctorDetailsEntity doctorDetails;
  const ReviewCard({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {

    final isModel = doctorDetails is DoctorDetailsModel;
    final List<DoctorReviewModel> reviewsList =
        isModel ? (doctorDetails as DoctorDetailsModel).reviewsList : [];

    final hasReviews = reviewsList.isNotEmpty;

    if (!hasReviews) {
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
                _buildDefaultAvatar(),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 42),
                Expanded(
                  child: Text(
                    AppStrings.reviewText,
                    style: AppStyle.styleMedium14(context).copyWith(
                      color: AppColors.whiteColor79,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    
    // If reviews exist, display them
    return Column(
      children: reviewsList.map((review) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
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
                  _buildDefaultAvatar(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.patientName,
                          style: AppStyle.styleRegular16(context).copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatCreatedAt(review.createdAt),
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
                          review.rating.toStringAsFixed(1),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 42),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:25),
                      child: Text(
                        textAlign:TextAlign.left,
                        review.comment,
                        style: AppStyle.styleMedium14(context).copyWith(
                          color: AppColors.whiteColor79,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatCreatedAt(DateTime? date) {
    if (date == null) return 'Unknown date';
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static Widget _buildDefaultAvatar() {
    return const CircleAvatar(
      radius: 30,
      backgroundColor: AppColors.lightGrey,
      child: Icon(
        Icons.person,
        color: AppColors.textPrimary,
        size: 30,
      ),
    );
  }
}
