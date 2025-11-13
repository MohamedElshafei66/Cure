import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/add_review_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_rate.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/success_add_review.dart';

class AddReviewBody extends StatelessWidget {
  final int doctorId;
  const AddReviewBody({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddReviewCubit, AddReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          // Show success dialog
          successAddingReview(context, onDone: () {
            // Pop with result to indicate success
            context.pop(true); // Go back to doctor details screen with success flag
          });
        } else if (state is AddReviewError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddReviewCubit>();
        final isLoading = state is AddReviewLoading;
        
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.yourRate,
                          style: AppStyle.styleRegular16(context).copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const ReviewRate(),
                        const SizedBox(height: 50),
                        Text(
                          AppStrings.yourReview,
                          style: AppStyle.styleRegular20(context).copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const ReviewTextField(),
                        const Spacer(),
                        CustomButton(
                          text: AppStrings.sendYourReview,
                          onPressed: isLoading
                              ? null
                              : () {
                                  final rating = cubit.rating;
                                  final comment = cubit.comment;
                                  
                                  if (rating == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please select a rating'),
                                        backgroundColor: AppColors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  
                                  if (comment.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please write a review'),
                                        backgroundColor: AppColors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  
                                  cubit.addReview(
                                    doctorId: doctorId,
                                    rating: rating.toInt(),
                                    comment: comment.trim(),
                                  );
                                },
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


