import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class DayAndTimeSchedule extends StatelessWidget {
  const DayAndTimeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImage(
            AppImages.calendarDoneImage,
            type: PathType.assets
        ),
        const SizedBox(
            width: 8
        ),
        Text(
          "Friday,July17 -4:00PM",
          style: AppStyle.styleMedium14(context)
              .copyWith(color: AppColors.textPrimary),
        ),
        const Spacer(),
        InkWell(
          onTap:(){
            context.pop();
          },
          child: Text(
            AppStrings.reschedule,
            style:AppStyle.styleMedium14(context).copyWith(
                color:AppColors.primary
            ),
          ),
        )
      ],
    );
  }
}
