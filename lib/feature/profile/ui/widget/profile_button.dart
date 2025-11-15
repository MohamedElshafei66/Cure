// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({
    this.icon,
    required this.title,
    this.showicon = true,
    this.onTap,
  });
  final String? icon;
  final String title;
  final bool showicon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 120),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
       
          child: Row(
            children: [
              if (showicon) Icon(Icons.add, color: Colors.white),
              Text(
                title,
                style: AppStyle.styleRegular16(
                  context,
                ).copyWith(color: Colors.white),
              ),
            ],
          ),
        
      ),
    );
  }
}
