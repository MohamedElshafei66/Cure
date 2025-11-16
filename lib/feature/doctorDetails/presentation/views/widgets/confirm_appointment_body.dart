import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/calender_date.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/time_date.dart';
import 'doctor_info.dart';

class ConfirmAppointmentBody extends StatelessWidget {
  const ConfirmAppointmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state.doctorDetails == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorInfo(doctorDetails: state.doctorDetails!),
              const SizedBox(height: 24),
              Text(
                AppStrings.selectDay,
                style: AppStyle.styleRegular20(context),
              ),
              const SizedBox(height: 16),
              const CalenderDate(),
              const SizedBox(height: 16),
              Text(
                AppStrings.selectTime,
                style: AppStyle.styleRegular20(context),
              ),
              const SizedBox(height: 16),
              const TimeDate(),
              const SizedBox(height: 16),
              PriceOfDoctor(doctorDetails: state.doctorDetails),
              const SizedBox(height: 12),
              CustomButton(
                text: AppStrings.continuePay,
                onPressed: () {
                  if (state.selectedDate != null && state.selectedTime != null) {
                    // Get the AppointmentCubit before navigation
                    final appointmentCubit = context.read<AppointmentCubit>();
                    context.push(
                      AppRoutes.payAfterScheduleScreen,
                      extra: appointmentCubit,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select date and time'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
