import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/cancellation_message.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/doctor_details.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/calender_date.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/time_date.dart';

class RescheduleViewBody extends StatelessWidget {
  const RescheduleViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                          height: 15
                      ),
                      CancellationMessage(),
                      SizedBox(
                          height: 24
                      ),
                      DoctorDetails(),
                      SizedBox(
                          height: 24
                      ),
                      CalenderDate(),
                      SizedBox(
                          height: 24
                      ),
                      TimeDate(),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: AppStrings.reschedule,
                onPressed:(){},
              ),
              const SizedBox(
                  height: 16
              ),
              CustomButton(
                text: AppStrings.cancel,
                onPressed:(){},
                color:AppColors.whiteColor,
                borderColor:AppColors.textHint,
                textColor:AppColors.textHint
              ),
              const SizedBox(
                  height:12
              ),
            ],
          ),
        );
      },
    );
  }
}
