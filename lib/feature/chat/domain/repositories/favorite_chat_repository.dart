import 'package:round_7_mobile_cure_team3/feature/chat/data/models/favourite_chat_model.dart';

abstract class FavoriteChatRepository {
  Future<FavouriteChatModel> getFavoriteChats();
  Future<FavouriteChatModel> addToFavoriteChats(String chatId);
}
