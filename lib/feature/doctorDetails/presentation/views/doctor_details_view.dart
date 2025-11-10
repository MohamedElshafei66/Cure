import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_body.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:DoctorDetailsAppbar(
        showActions:true,
        text:AppStrings.doctorDetailsTitle,
      ),
      body:DoctorDetailsBody()
    );
  }
}

