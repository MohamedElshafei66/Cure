import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/pay_after_schedule_body.dart';

class PayAfterScheduleScreen extends StatelessWidget {
  const PayAfterScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DoctorDetailsAppbar(
        text: AppStrings.bookAppointment,
      ),
      body: const PayAfterScheduleBody(),
    );
  }
}
