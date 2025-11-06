import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CustomContainer extends StatelessWidget {
  final String iconPath;
  final String text;

  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    required this.iconPath,
    required this.text,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 12,),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 24, width: 24),
            const SizedBox(width: 8),
            Text(text, style: AppStyle.styleMedium16( context)),
          ],
        ),
      ),
    );
  }
}