import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

AppBar customAppBar(BuildContext context, {final String? title}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Image.asset(AppIcons.backArrow),
    ),
    title: Text(
      title ?? AppStrings.notifications,
      style: AppStyle.styleRegular24(context),
    ),
    centerTitle: true,
  );
}