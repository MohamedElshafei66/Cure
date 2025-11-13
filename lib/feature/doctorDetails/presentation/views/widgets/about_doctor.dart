import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entites/doctor_details_entity.dart';

class AboutDoctor extends StatelessWidget {
  final DoctorDetailsEntity doctorDetails;
  const AboutDoctor({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.aboutMeTitle,
            style: AppStyle.styleRegular20(context).copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            doctorDetails.doctorAbout.isNotEmpty
                ? doctorDetails.doctorAbout
                : AppStrings.aboutMeDescription,
            style: AppStyle.styleMedium12(context).copyWith(
              color: AppColors.whiteColor79,
            ),
          ),
        ],
      ),
    );
  }
}
