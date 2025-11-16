import '../../../../core/constants/secure_storage_data.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_services.dart';
import '../models/unread_chat_model.dart';

class UnreadChatRemoteDataSource {
  final ApiServices apiServices;

  UnreadChatRemoteDataSource({String? token, SecureStorageService? secureStorage})
      : apiServices = ApiServices(token: token);

  Future<UnreadChatModel> getUnreadChats() async {
    try {
      final response = await apiServices.get(endPoint: ApiEndpoints.chatsUnread);
      return UnreadChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load unread chats: $e');
    }
  }
}
