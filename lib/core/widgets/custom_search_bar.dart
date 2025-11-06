import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SearchBar(
        elevation: WidgetStateProperty.all<double>(1),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.lightGrey),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        leading: Image.asset(AppIcons.search),
        controller: controller,
        hintText: 'Search for specialty, doctor',
        hintStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: getResponsive(context, fontSize: 14),
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
            color: Color(0xff6D7379),
          ),
        ),
      ),
    );
  }
}
