import 'package:round_7_mobile_cure_team3/feature/chat/data/models/favourite_chat_model.dart';
import '../../domain/repositories/favorite_chat_repository.dart';
import '../data_sources/favorite_chat_remote_data_source.dart';

class FavoriteChatRepositoryImpl implements FavoriteChatRepository {
  final FavoriteChatRemoteDataSource remote;

  FavoriteChatRepositoryImpl(this.remote);

  @override
  Future<FavouriteChatModel> getFavoriteChats() {
    return remote.getFavoriteChats();
  }

  @override
  Future<FavouriteChatModel> addToFavoriteChats(String chatId) {
    return remote.addFavorite(chatId);
  }
}
