import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:svg_image/svg_image.dart';

class SelectPaymentMethod extends StatelessWidget {
  const SelectPaymentMethod({super.key});

  final List<Map<String, dynamic>> methods = const [
    {
      'name': AppStrings.creditCard,
      'image': AppImages.visaImage,
    },
    {
      'name': AppStrings.cash,
      'image': AppImages.cashImage,
    },
    {
      'name': AppStrings.applePay,
      'image': AppImages.applePayImage,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        return Column(
          children: methods.map((method) {
            final bool isSelected = state.paymentMethod == method['name'] ||
                (state.paymentMethod == null && method == methods.first);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.green.withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.transparent,
                ),
              ),
              child: ListTile(
                onTap: () {
                  context.read<AppointmentCubit>().selectPaymentMethod(
                        method['name'] as String,
                      );
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                title: Text(
                  method['name'] as String,
                  style: AppStyle.styleMedium16(context).copyWith(
                    color:
                        isSelected ? AppColors.green : AppColors.whiteColor79,
                  ),
                ),
                trailing: SvgImage(
                  method['image'] as String,
                  type: PathType.assets,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
