import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/model/notification_model.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/manage/cubit/notification_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/widgets/empty_body.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/widgets/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
void initState() {
  super.initState();
  final cubit = context.read<NotificationCubit>();
  cubit.fetchNotifications();
  // cubit.startLiveNotifications();
}

@override
// void dispose() {
//   // context.read<NotificationCubit>().stopLiveNotifications();
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.notifications), centerTitle: true),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return EmptyBodyWidget(
                imagePath: AppImages.notificationsEmptyImage,
                mainTitle: AppStrings.notificationTitle,
                subTitle: AppStrings.emptyNotificationDescription,
              );
            }

            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final NotificationModel model = state.notifications[index];
                return NotificationCardWidget(
                  notificationModel: model,
                  onTap: () {
                    context.read<NotificationCubit>().markAsRead(model.id);
                  },
                );
              },
            );
          } else if (state is NotificationError) {
            return EmptyBodyWidget(
              imagePath: AppImages.notificationsEmptyImage,
              mainTitle: AppStrings.notificationTitle,
              subTitle: AppStrings.emptyNotificationDescription,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
