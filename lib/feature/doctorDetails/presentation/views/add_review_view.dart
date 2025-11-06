import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/add_review_body.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.whiteColor,
      appBar:DoctorDetailsAppbar(
          text:AppStrings.review
      ),
      body:AddReviewBody(),
    );
  }
}
