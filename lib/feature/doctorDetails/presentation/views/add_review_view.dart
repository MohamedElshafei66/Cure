import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/add_review_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/add_review_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/add_review_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/add_review_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/add_review_body.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';

class AddReviewScreen extends StatelessWidget {
  final int doctorId;
  const AddReviewScreen({super.key, required this.doctorId});
  
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return BlocProvider(
      create: (context) => AddReviewCubit(
        addReviewUseCase: AddReviewUseCase(
          AddReviewRepoImpl(
            remoteDataSource: AddReviewRemoteDataSourceImpl(
              apiServices: ApiServices(authProvider: authProvider),
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: const DoctorDetailsAppbar(
          text: AppStrings.review,
        ),
        body: AddReviewBody(doctorId: doctorId),
      ),
    );
  }
}
