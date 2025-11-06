import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class CancellationMessage extends StatelessWidget {
  const CancellationMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:AppColors.orangeE9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: SvgImage(
                AppImages.warnImage,
                type:PathType.assets
            ),
          ),
          const SizedBox(
              width:10
          ),
          Expanded(
            child: Text(
                AppStrings.cancelBooking,
                style:AppStyle.styleMedium14(context).copyWith(
                    color:AppColors.orange
                )
            ),
          ),
        ],
      ),
    );
  }
}
