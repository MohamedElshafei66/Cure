import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/models/favourite_chat_model.dart';
import '../../../../core/constants/auth_provider.dart';
import '../../../../core/network/api_services.dart';
import '../../../../core/network/api_endpoints.dart';

class FavoriteChatRemoteDataSource {
  final ApiServices apiServices;

  FavoriteChatRemoteDataSource({required AuthProvider authProvider})
      : apiServices = ApiServices(authProvider: authProvider);

  Future<FavouriteChatModel> addFavorite(String chatId) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.markChatAsFavourite,
        body: {'id': chatId},
      );

      // apiServices.post() returns response.data directly, not a response object
      return FavouriteChatModel.fromJson(response);

    } catch (e) {
      throw Exception('Dio error: $e');
    }
  }

  Future<FavouriteChatModel> getFavoriteChats() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.favouriteChat,
      );

      // apiServices.get() returns response.data directly, not a response object
      return FavouriteChatModel.fromJson(response);

    } catch (e) {
      throw Exception('Failed to load favorite chats: $e');
    }
  }
}
