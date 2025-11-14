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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: doctors!.map((doctor) => DoctorCard(doctor: doctor)).toList(),
      );
    }

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is NearestDoctorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NearestDoctorLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.doctors
                .map((doctor) => DoctorCard(doctor: doctor))
                .toList(),
          );
        } else if (state is DoctorError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
