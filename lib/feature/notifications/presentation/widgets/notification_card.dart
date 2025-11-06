
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/model/notification_model.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    required this.notificationModel,
    super.key,
    this.onTap,
  });
  final void Function()? onTap;
  final NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xffE8EFF8),
          child: Image.asset(
            notificationModel.imageUrl ?? AppIcons.upcomming,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(notificationModel.title ?? ''), const Text('4h')],
        ),
        subtitle: Text(notificationModel.description ?? '', maxLines: 1),
      ),
    );
  }
}