import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';

class DoctorsNearby extends StatelessWidget {
  final List<DoctorModel>? doctors;
  const DoctorsNearby({super.key, this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors != null) {
      // Limit to first 3-4 doctors for home screen
      final limitedDoctors = doctors!.take(4).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: limitedDoctors.map((doctor) => DoctorCard(doctor: doctor)).toList(),
      );
    }

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is NearestDoctorLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is NearestDoctorLoaded) {
          if (state.doctors.isEmpty) {
            // If no nearest doctors, try to fetch all doctors
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<DoctorCubit>().fetchAllDoctors();
            });
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          // Limit to first 4 doctors for home screen
          final limitedDoctors = state.doctors.take(4).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: limitedDoctors
                .map((doctor) => DoctorCard(doctor: doctor))
                .toList(),
          );
        } else if (state is DoctorLoaded) {
          // Fallback to all doctors if nearest doctors failed
          final limitedDoctors = state.doctors.take(4).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: limitedDoctors
                .map((doctor) => DoctorCard(doctor: doctor))
                .toList(),
          );
        } else if (state is DoctorError) {
          // Try to fetch all doctors as fallback
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DoctorCubit>().fetchAllDoctors();
          });
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return const SizedBox(height: 200);
      },
    );
  }
}
