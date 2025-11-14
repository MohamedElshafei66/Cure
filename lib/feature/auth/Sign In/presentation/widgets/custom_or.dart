import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CustomOr extends StatelessWidget {
  const CustomOr({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color:AppColors.chatRecieve)),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(AppStrings.or,style: AppStyle.styleMedium16(context),),
        ),
        Expanded(child: Divider(color:AppColors.chatRecieve)),
      ],
    );
  }
}