part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  final bool? notificationEnabled;
  ProfileLoaded(this.profile, {this.notificationEnabled});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final ProfileModel profile;
  ProfileUpdated(this.profile);
}

class NotificationToggling extends ProfileState {}

class NotificationToggled extends ProfileState {
  final bool enabled;
  NotificationToggled(this.enabled);
}

class LoggingOut extends ProfileState {}

class LoggedOut extends ProfileState {}



