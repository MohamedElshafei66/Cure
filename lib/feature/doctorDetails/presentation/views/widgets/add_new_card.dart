import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class AddNewCard extends StatelessWidget {
  const AddNewCard({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){},
      child: DottedBorder(
        options:RoundedRectDottedBorderOptions(
          radius:Radius.circular(10),
          strokeWidth:1,
          color:AppColors.primary,
          dashPattern:[9,9],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                  Icons.add,
                  color:AppColors.primary,
                  size: 24
              ),
              const SizedBox(
                  width:8
              ),
              Text(
                  AppStrings.addNewCard,
                  style:AppStyle.styleMedium16(context).copyWith(
                      color:AppColors.primary
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
