import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class DoctorDetailsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showActions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const DoctorDetailsAppbar({
    super.key,
    this.showActions = false
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:AppColors.whiteColor,
      centerTitle:true,
      elevation: 0,
      title:Text(
          AppStrings.doctorDetailsTitle,
          style:AppStyle.styleRegular24(context).copyWith(
              color:AppColors.blackColor
          )
      ),
      leading:IconButton(
          onPressed:(){},
          icon:Icon(
            Icons.arrow_back_ios_rounded,
            color:AppColors.textPrimary,
          )
      ),
      actions: showActions
          ? [
           InkWell(
             onTap:(){},
             child:Padding(
               padding: const EdgeInsets.only(right:15),
               child: SvgImage(
                   AppImages.chatImage,
                   type:PathType.assets
               ),
             )
           )
      ]:[],
    );
  }
}
