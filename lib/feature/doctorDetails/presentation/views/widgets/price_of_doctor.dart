import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class PriceOfDoctor extends StatelessWidget {
  const PriceOfDoctor({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text:AppStrings.priceLabel,
                style:AppStyle.styleRegular24(context).copyWith(
                    color:AppColors.textPrimary
                ),
                children: [
                  TextSpan(
                    text:AppStrings.hourLabel,
                    style:AppStyle.styleRegular14(context).copyWith(
                        color:AppColors.chatRecieve,
                        fontWeight:FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
              AppStrings.priceValue,
              style:AppStyle.styleMedium16(context).copyWith(
                  color:AppColors.red,
                  fontWeight:FontWeight.w600
              )
          ),
        ],
      ),
    );
  }
}
