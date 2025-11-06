import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/widgets/empty_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.white,
      appBar: customAppBar(context),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: isEmpty
            ? const EmptyBodyWidget(
                imagePath: AppImages.notificationsEmptyImage,
                mainTitle: AppStrings.emptyNotificationTitle,
                subTitle: AppStrings.emptyNotificationDescription,
              )
            : const Scaffold(),
      ),
    );
  }
}