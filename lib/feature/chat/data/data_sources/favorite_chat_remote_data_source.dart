import 'package:round_7_mobile_cure_team3/feature/chat/data/models/favourite_chat_model.dart';
import '../../../../core/network/api_services.dart';
import '../../../../core/network/api_endpoints.dart';

class FavoriteChatRemoteDataSource {
  final ApiServices apiServices;

  FavoriteChatRemoteDataSource(String token)
      : apiServices = ApiServices(token: token);

  Future<FavouriteChatModel> addFavorite(String chatId) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.markChatAsFavourite,
        body: {'id': chatId},
      );

      return FavouriteChatModel.fromJson(response.data);

    } catch (e) {
      throw Exception('Dio error: $e');
    }
  }

  Future<FavouriteChatModel> getFavoriteChats() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.favouriteChat,
      );

      return FavouriteChatModel.fromJson(response.data);

    } catch (e) {
      throw Exception('Failed to load favorite chats: $e');
    }
  }
}
