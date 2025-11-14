import '../../data/models/unread_chat_model.dart';

abstract class UnreadChatState {}

class UnreadChatInitial extends UnreadChatState {}

class UnreadChatLoading extends UnreadChatState {}

class UnreadChatLoaded extends UnreadChatState {
  final List<DoctorDTO> doctors;

  UnreadChatLoaded(this.doctors);
}

class UnreadChatError extends UnreadChatState {
  final String error;

  UnreadChatError(this.error);
}
