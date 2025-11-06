import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.textColor
  });
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:color ?? AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:BorderSide(
              color:borderColor ?? Colors.transparent
            )
          ),
        ),
        onPressed:onPressed,
        child:  Text(
          text,
          style:AppStyle.styleMedium16(context).copyWith(
            color:textColor ?? AppColors.whiteColor
          )
        ),
      ),
    );
  }
}
