import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/calender_date.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/time_date.dart';
import 'doctor_info.dart';

class ConfirmAppointmentBody extends StatefulWidget {
  const ConfirmAppointmentBody({super.key});

  @override
  State<ConfirmAppointmentBody> createState() => _ConfirmAppointmentBodyState();
}

class _ConfirmAppointmentBodyState extends State<ConfirmAppointmentBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorInfo(),
          const SizedBox(
              height: 24
          ),
          Text(
            AppStrings.selectDay,
            style: AppStyle.styleRegular20(context),
          ),
          const SizedBox(
              height: 16
          ),
          CalenderDate(),
          const SizedBox(
              height: 16
          ),
          Text(
            AppStrings.selectTime,
            style: AppStyle.styleRegular20(context),
          ),
          const SizedBox(
              height: 16
          ),
          TimeDate(),
          const SizedBox(
              height: 16
          ),
          PriceOfDoctor(),
          const SizedBox(
              height: 12
          ),
          CustomButton(
              text:AppStrings.continuePay,
              onPressed:(){
                context.push(AppRoutes.payAfterScheduleScreen);
              }
          ),
          const SizedBox(
              height:30
          ),
        ],
      ),
    );
  }
}
