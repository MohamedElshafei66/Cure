import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children:[
        Row(
          children: [
            SvgImage(
                AppImages.calendarImage,
                type:PathType.assets
            ),
            SizedBox(
              width:4,
            ),
            Text(
                "Monday, July 21 - 11:00 AM",
                style:AppStyle.styleRegular14(context).copyWith(
                    color:AppColors.textPrimary
                )
            ),
            Spacer(),
            Text(
                AppStrings.upComing,
                style: AppStyle.styleRegular14(context).copyWith(
                    color:AppColors.primary
                )
            ),
          ],
        ),
        SizedBox(
          height:16,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: size.width * 0.06,
              backgroundImage:CachedNetworkImageProvider('https://images.unsplash.com/photo-1550831107-1553da8c8464'),
            ),
            const SizedBox(
                width:8
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    AppStrings.doctorName,
                    style:AppStyle.styleRegular16(context).copyWith(
                        color:AppColors.blackColor48
                    )
                ),
                SizedBox(
                  height:4,
                ),
                Text(
                    AppStrings.doctorSpeciality,
                    style:AppStyle.styleMedium14(context).copyWith(
                        color:AppColors.textSecondary,
                        fontWeight:FontWeight.w400
                    )
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap:(){},
              child: SvgImage(
                  AppImages.chatImage,
                  type:PathType.assets
              ),
            )
          ],
        ),
        SizedBox(
          height:10,
        ),
        Row(
          children: [
            SvgImage(
                AppImages.locationImage,
                type:PathType.assets
            ),
            const SizedBox(
                width: 4
            ),
            Expanded(
              child: Text(
                  AppStrings.doctorLocation,
                  style:AppStyle.styleMedium16(context).copyWith(
                      color:AppColors.textSecondary,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ],
        ),
      ],
    );
  }
}
