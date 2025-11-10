import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class SpecialistCard extends StatelessWidget {
  final String? image;
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const SpecialistCard({
    super.key,
    required this.image,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = selected ? AppColors.primary : AppColors.grey;
    final Color backgroundColor = selected ? AppColors.primary : Colors.white;
    final Color textColor = selected ? Colors.white : Colors.black;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      splashColor: AppColors.primary.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null) ...[
              Image.asset(image!, height: 20, width: 20, color: textColor),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppStyle.styleMedium16(
                context,
              ).copyWith(fontWeight: FontWeight.w500, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
