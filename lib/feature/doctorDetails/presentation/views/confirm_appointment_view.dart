import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'widgets/confirm_appointment_body.dart';
import 'widgets/doctor_details_app_bar.dart';
class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar:DoctorDetailsAppbar(
        text:AppStrings.bookAppointment,
      ),
      body:ConfirmAppointmentBody(),
    );
  }
}
