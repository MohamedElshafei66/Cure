import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/dependincy_injection.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/add_review_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/add_review_body.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';

class AddReviewScreen extends StatelessWidget {
  final int doctorId;
  const AddReviewScreen({super.key, required this.doctorId});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddReviewCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: DoctorDetailsAppbar(
          text: AppStrings.review,
        ),
        body: AddReviewBody(doctorId: doctorId),
      ),
    );
  }
}
