import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/favorite_chat_repository.dart';
import 'favourite_chat_state.dart';

class FavoriteChatCubit extends Cubit<FavoriteChatState> {
  final FavoriteChatRepository repository;

  FavoriteChatCubit(this.repository) : super(FavoriteChatInitial());

  void fetchFavoriteChats() async {
    emit(FavoriteChatLoading());
    try {
      final result = await repository.getFavoriteChats();

      emit(FavoriteChatLoaded(result.data.doctorsListDTO));
    } catch (e) {
      emit(FavoriteChatError(e.toString()));
    }
  }

  void addToFavorite(String chatId) async {
    emit(FavoriteChatLoading());
    try {
      await repository.addToFavoriteChats(chatId);
      fetchFavoriteChats();
    } catch (e) {
      emit(FavoriteChatError(e.toString()));
    }
  }
}
