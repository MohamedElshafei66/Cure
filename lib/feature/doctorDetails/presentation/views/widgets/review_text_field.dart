import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
class ReviewTextField extends StatelessWidget {

  const ReviewTextField({super.key,});
  @override
  Widget build(BuildContext context) {
    return  TextField(
      maxLines:8,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText:AppStrings.writeYourReview,
        hintStyle: AppStyle.styleMedium14(context).copyWith(
          color: AppColors.whiteColor79,
        ),
        contentPadding: const EdgeInsets.all(16),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
