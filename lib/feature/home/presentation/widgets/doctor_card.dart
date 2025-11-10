import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class DoctorCard extends StatefulWidget {
  DoctorCard({super.key, required this.isFavourite});

  bool isFavourite;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    const double heartSize = 24;

    return InkWell(
      onTap: () {
        context.push(AppRoutes.doctorDetailsScreen);
      },
      child: Container(
        // height: 64,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.grey, width: 1.4),
        ),
        child: Row(
          children: [
            Flexible(child: Image.asset(AppImages.doctorImage)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Robert Johnson', style: AppStyle.styleRegular16(context)),
                const SizedBox(height: 4),
                Text(
                  'Orthopedic | El-Nasr Hospital',
                  style: AppStyle.styleMedium12(context),
                ),
                Row(
                  children: [
                    Image.asset(AppIcons.star),
                    const SizedBox(width: 4),
                    Text('4.8', style: AppStyle.styleRegular12(context)),
                    const SizedBox(width: 4),
                    Image.asset(AppIcons.clock),
                    const SizedBox(width: 4),
                    Text(
                      '9:30am - 8:00pm',
                      style: AppStyle.styleRegular12(context),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () => setState(() {
                widget.isFavourite = !widget.isFavourite;
              }),
              child: SizedBox(
                height: heartSize,
                width: heartSize,
                child: widget.isFavourite
                    ? Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                        size: heartSize,
                      )
                    : Image.asset(
                        AppIcons.heartPng,
                        color: Colors.black,
                        height: heartSize,
                        width: heartSize,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
