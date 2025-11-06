import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_rate.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/success_add_review.dart';

class AddReviewBody extends StatelessWidget {
  const AddReviewBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(
                        height: 16
                    ),
                    const ReviewRate(),
                    const SizedBox(
                        height: 50
                    ),
                    Text(
                      AppStrings.yourReview,
                      style: AppStyle.styleRegular20(context).copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(
                        height: 10
                    ),
                    const ReviewTextField(),
                    const Spacer(),
                    CustomButton(
                      text:AppStrings.sendYourReview,
                      onPressed:(){
                        successAddingReview(context);
                      },
                    ),
                    const SizedBox(
                        height:12
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


