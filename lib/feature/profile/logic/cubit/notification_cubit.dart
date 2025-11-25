import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final ProfileRepository repo;

  bool isOn = false;

  NotificationCubit(this.repo) : super(NotificationInitial());

  Future<void> loadStatus() async {
    emit(NotificationLoading());

    emit(NotificationLoaded(isOn));
  }

  Future<void> toggle() async {
    emit(NotificationLoading());

    final success = await repo.toggleNotification();

    if (success) {
      isOn = !isOn;
      emit(NotificationLoaded(isOn));
    } else {
      emit(NotificationError("Failed to toggle notification"));
    }
  }
}
