import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/model/notification_model.dart';

const Map<int, String> notificationTypes = {
  0: 'Booking',
  1: 'Chating',
  2: 'Review',
  3: 'Payment',
  4: 'Refund',
  5: 'Admin',
  6: 'Dispute',
  7: 'General',
  8: 'System',
  9: 'RoleAssignment',
  10: 'Security',
};

class NotificationCardWidget extends StatefulWidget {
  final NotificationModel notificationModel;
  final VoidCallback? onTap;

  const NotificationCardWidget({
    super.key,
    required this.notificationModel,
    this.onTap,
  });

  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  late bool isRead;

  @override
  void initState() {
    super.initState();
    isRead = widget.notificationModel.isRead;
  }

  void toggleReadStatus() {
    setState(() {
      isRead = !isRead;

    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isRead ? Colors.grey.shade300 : const Color(0xffE8EFF8),
          child: Image.asset(AppIcons.upcomming, height: 22),
        ),
        title: Text(
          notificationTypes[widget.notificationModel.types] ?? 'Unknown',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold),
        ),
        subtitle: Text(
          '${widget.notificationModel.content} ',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: TextButton(
          onPressed: toggleReadStatus,
          child: Text(
            _formatDate(widget.notificationModel.createdAt),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
