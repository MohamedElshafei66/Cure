import '../../data/models/favourite_chat_model.dart';

abstract class FavoriteChatState {}

class FavoriteChatInitial extends FavoriteChatState {}

class FavoriteChatLoading extends FavoriteChatState {}

class FavoriteChatLoaded extends FavoriteChatState {
  final List<DoctorDTO> doctors;

  FavoriteChatLoaded(this.doctors);
}

class FavoriteChatError extends FavoriteChatState {
  final String error;

  FavoriteChatError(this.error);
}
