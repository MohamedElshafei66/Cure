import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/dependincy_injection.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_body.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final int? doctorId;
  const DoctorDetailsScreen({super.key, this.doctorId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorDetailsCubit>(
          create: (context) => getIt<DoctorDetailsCubit>()
            ..fetchDoctorDetails(doctorId ?? 2),
        ),
        BlocProvider<AppointmentCubit>(
          create: (context) => getIt<AppointmentCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DoctorDetailsAppbar(
          showActions: true,
          text: AppStrings.doctorDetailsTitle,
        ),
        body: const DoctorDetailsBody(),
      ),
    );
  }
}

