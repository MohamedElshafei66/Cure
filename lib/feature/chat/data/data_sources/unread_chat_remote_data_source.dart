import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_services.dart';
import '../models/unread_chat_model.dart';

class UnreadChatRemoteDataSource {
  final ApiServices apiServices;

     UnreadChatRemoteDataSource({required AuthProvider authProvider})
     :apiServices = ApiServices(authProvider: authProvider);

  Future<UnreadChatModel> getUnreadChats() async {
    try {
      final response = await apiServices.get(endPoint: ApiEndpoints.chatsUnread);
      return UnreadChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load unread chats: $e');
    }
  }
}
