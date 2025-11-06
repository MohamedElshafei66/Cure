import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

void cancelBooking(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      final isSmallScreen = size.width < 400;

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 20 : 40,
          vertical: isSmallScreen ? 40 : 80,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 40,
            vertical: isSmallScreen ? 25 : 40,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgImage(
                  AppImages.warningImage,
                  type:PathType.assets
              ),
              SizedBox(
                height:30,
              ),
              FittedBox(
                fit:BoxFit.fill,
                child: Text(
                    AppStrings.warning,
                    textAlign: TextAlign.center,
                    style:AppStyle.styleRegular20(context).copyWith(
                        color:AppColors.orange,
                        fontWeight:FontWeight.w600
                    )
                ),
              ),
              SizedBox(
                  height:8
              ),
              Text(
                textAlign:TextAlign.center,
                AppStrings.cancelBooking,
                style:AppStyle.styleRegular14(context).copyWith(
                    color:AppColors.textSecondary
                ),
              ),
              SizedBox(
                  height:15
              ),
              Text(
                  AppStrings.areYouSure,
                  style:AppStyle.styleRegular14(context).copyWith(
                      color:AppColors.textSecondary
                  )
              ),
              SizedBox(
                  height:15
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:() => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.textPrimary,
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 12 : 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                      AppStrings.yesCancel,
                      style:AppStyle.styleRegular16(context).copyWith(
                          color:AppColors.whiteColor
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}