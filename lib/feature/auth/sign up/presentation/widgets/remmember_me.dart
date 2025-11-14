import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';

class RemmberMe extends StatefulWidget {
  const RemmberMe({super.key});

  @override
  State<RemmberMe> createState() => _RemmberMeState();
}

class _RemmberMeState extends State<RemmberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          side: BorderSide(color:  AppColors.primary,strokeAlign: BorderSide.strokeAlignCenter),
          activeColor: AppColors.primary,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        const Text(AppStrings.rememberMe),
      ],
    );
  }
}