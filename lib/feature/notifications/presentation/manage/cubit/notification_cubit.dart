import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/model/notification_model.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/domain/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repository;

  NotificationCubit(this.repository) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final notifications = await repository.getNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await repository.markAsRead(id);
      fetchNotifications();
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}