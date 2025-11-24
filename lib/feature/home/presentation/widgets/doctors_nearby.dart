import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorsNearby extends StatelessWidget {
  final List<DoctorModel>? doctors;
  const DoctorsNearby({super.key, this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors != null) {
      final limitedDoctors = doctors!.take(4).toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: limitedDoctors
            .map((doctor) => DoctorCard(doctor: doctor))
            .toList(),
      );
    }

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        final loading = state is DoctorLoading || state is DoctorInitial;
        List<DoctorModel> list = [];

        if (state is NearestDoctorLoaded) {
          if (state.doctors.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<DoctorCubit>().fetchAllDoctors();
            });
          } else {
            list = state.doctors.take(4).toList();
          }
        }

        if (state is DoctorLoaded) {
          list = state.doctors.take(4).toList();
        }

        if (state is DoctorError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DoctorCubit>().fetchAllDoctors();
          });
        }

        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: loading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: loading
                ? List.generate(
                    4,
                    (_) => DoctorCard(
                      doctor: DoctorModel(
                        price: 0,
                        isFavourite: false,
                        specialistTitle: "Loading",
                        address: "Loading",
                        specialityId: 0,
                        about: "Loading",
                        id: 0,
                        fullName: "Loading",
                        rating: 0,
                        imgUrl: "",
                      ),
                    ),
                  )
                : list.map((doctor) => DoctorCard(doctor: doctor)).toList(),
          ),
        );
      },
    );
  }
}
