import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/about_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info_details.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_and_rate.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/review_card.dart';

class DoctorDetailsBody extends StatefulWidget {
  const DoctorDetailsBody({super.key});

  @override
  State<DoctorDetailsBody> createState() => _DoctorDetailsBodyState();
}

class _DoctorDetailsBodyState extends State<DoctorDetailsBody> {
  bool isFavorite = false;
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
          DoctorInfoDetails(),
          const SizedBox(
              height:40
          ),
          AboutDoctor(),
          const SizedBox(
              height: 24
          ),
          ReviewAndRate(),
          const SizedBox(
              height:24
          ),
          ReviewCard(),
          PriceOfDoctor(),
          const SizedBox(
              height: 12
          ),
          CustomButton(
            text:AppStrings.bookAppointment,
            onPressed:(){},
          )
        ],
      ),
    );
  }
}


