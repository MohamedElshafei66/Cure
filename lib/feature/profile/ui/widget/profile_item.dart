// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class ProfileItem extends StatelessWidget {
  final String icon;
  Color color = AppColors.lightGrey;
  String title;
  final String? icons;
  final bool showArrow;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  ProfileItem({
    required this.icon,
    required this.title,
    this.icons,
    this.showArrow = true,
    this.switchValue,
     this.onSwitchChanged,
     this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector
      (
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            Gap(15),
            Text(title, style: AppStyle.styleRegular16(context)),
            Spacer(),
             if (onSwitchChanged != null)
              Switch(
                value: switchValue ?? false,
                onChanged: onSwitchChanged,
                activeColor: Colors.green, 
              )
            else if (showArrow)
              Padding(
                padding: const EdgeInsets.only(right: 5,),
                child: Image.asset(icons ?? AppIcons.arrow, width: 40, height: 40),
              ),
          ],
        ),
      ),
    );
  }
}
