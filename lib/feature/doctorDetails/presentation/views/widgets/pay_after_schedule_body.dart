import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/add_new_card.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/day_and_time_schedule.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_info.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/price_of_doctor.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/select_payment_method.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class PayAfterScheduleBody extends StatelessWidget {
  const PayAfterScheduleBody({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorInfo(),
                  const SizedBox(
                      height: 32
                  ),
                  const DayAndTimeSchedule(),
                  const SizedBox(
                      height: 50
                  ),
                  Text(
                    AppStrings.paymentMethod,
                    style: AppStyle.styleRegular20(context),
                  ),
                  const SizedBox(
                      height: 16
                  ),
                  const SelectPaymentMethod(),
                  const SizedBox(
                      height: 8
                  ),
                  const AddNewCard(),
                  const Spacer(),
                  Column(
                    children: [
                      const PriceOfDoctor(),
                      const SizedBox(
                          height: 12
                      ),
                      CustomButton(
                        text: AppStrings.pay,
                        onPressed:(){},
                      ),
                    ],
                  ),
                  SizedBox(
                    height:29,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
