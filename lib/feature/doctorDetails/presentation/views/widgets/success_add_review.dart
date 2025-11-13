import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

void successAddingReview(BuildContext context, {VoidCallback? onDone}) {
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
              CircleAvatar(
                backgroundColor:AppColors.lightGrey,
                radius:50,
                child: Icon(
                  Icons.check,
                  color:AppColors.primary,
                  size:50,
                ),
              ),
              FittedBox(
                fit:BoxFit.fill,
                child: Text(
                    AppStrings.thankForReview,
                    textAlign: TextAlign.center,
                    style:AppStyle.styleRegular24(context).copyWith(
                        color:AppColors.textPrimary
                    )
                ),
              ),
              SizedBox(
                  height:24
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:() {
                    Navigator.pop(context);
                    onDone?.call();
                  },
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
                      AppStrings.done,
                      style:AppStyle.styleRegular16(context).copyWith(
                          color:AppColors.whiteColor
                      )
                  ),
                ),
              ),
              SizedBox(
                  height: 15
              ),
              GestureDetector(
                onTap:() {
                  Navigator.pop(context);
                },
                child: Text(
                    AppStrings.backToHome,
                    style:AppStyle.styleRegular14(context).copyWith(
                        color:AppColors.textPrimary
                    )
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}