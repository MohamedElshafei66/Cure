import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/about_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info_details.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_and_rate.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_card.dart';

class DoctorDetailsBody extends StatelessWidget {
  final String? fallbackImageUrl;
  const DoctorDetailsBody({super.key, this.fallbackImageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorDetailsCubit, DoctorDetailsState>(
      listener: (context, state) {
        if (state is DoctorDetailsLoaded) {
          context.read<AppointmentCubit>().setDoctorDetails(state.doctorDetails);
        }
      },
      builder: (context, state) {
        
        if (state is DoctorDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DoctorDetailsError) {

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<DoctorDetailsCubit>();
                    if (cubit.currentDoctorId != null) {
                      cubit.fetchDoctorDetails(cubit.currentDoctorId!);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (state is DoctorDetailsLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorInfo(
                  doctorDetails: state.doctorDetails,
                  fallbackImageUrl: fallbackImageUrl,
                ),
                const SizedBox(height: 24),
                DoctorInfoDetails(doctorDetails: state.doctorDetails),
                const SizedBox(height: 40),
                AboutDoctor(doctorDetails: state.doctorDetails),
                const SizedBox(height: 24),
                ReviewAndRate(doctorDetails: state.doctorDetails),
                const SizedBox(height: 24),
                ReviewCard(doctorDetails: state.doctorDetails),
                PriceOfDoctor(doctorDetails: state.doctorDetails),
                const SizedBox(height: 12),
                CustomButton(
                  text: AppStrings.bookAppointment,
                  onPressed: () {
                    // Get the AppointmentCubit before navigation
                    final appointmentCubit = context.read<AppointmentCubit>();
                    context.push(
                      AppRoutes.confirmAppointmentScreen,
                      extra: appointmentCubit,
                    );
                  },
                ),
                const SizedBox(height: 29),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}


