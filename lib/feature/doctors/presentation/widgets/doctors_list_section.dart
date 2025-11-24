import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';

class DoctorsListSection extends StatelessWidget {
  final SearchState searchState;

  const DoctorsListSection({
    super.key,
    required this.searchState,
  });

  @override
  Widget build(BuildContext context) {
    // Show search results if user performed a search
    if (searchState is SearchLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (searchState is SearchLoaded) {
      final doctors = (searchState as SearchLoaded).doctors;
      if (doctors.isEmpty) {
        return _buildEmptyState(context, 'No doctors found.');
      }
      return Column(
        children: doctors.map((doc) => DoctorCard(doctor: doc)).toList(),
      );
    }

    if (searchState is SearchEmpty) {
      return _buildEmptyState(context, 'No doctors found.');
    }

    if (searchState is SearchFailed) {
      return _buildErrorState(
        context,
        (searchState as SearchFailed).message,
      );
    }

    // Default: Show all doctors
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, doctorState) {
        if (doctorState is DoctorLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (doctorState is DoctorLoaded) {
          if (doctorState.doctors.isEmpty) {
            return _buildEmptyState(context, 'No doctors available.');
          }
          return Column(
            children: doctorState.doctors
                .map((doc) => DoctorCard(doctor: doc))
                .toList(),
          );
        }

        if (doctorState is DoctorError) {
          return _buildErrorState(context, doctorState.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          message,
          style: AppStyle.styleMedium16(context),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          message,
          style: AppStyle.styleMedium16(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

