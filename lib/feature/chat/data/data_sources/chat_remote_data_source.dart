import '../models/chat_model.dart';
import '../models/search_chat_model.dart';
import '../../../../core/network/api_services.dart';
import '../../../../core/network/api_endpoints.dart';

class ChatRemoteDataSource {
  final ApiServices apiServices;

  ChatRemoteDataSource({String? token,})
      : apiServices = ApiServices(token: token, );

  Future<ChatModel> getChatsList() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.chatsList,
      );
      return ChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load chats list: $e');
    }
  }

  Future<ChatModel> startChat(Map<String, dynamic> body) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.startChat,
        body: body,
      );
      return ChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to start chat: $e');
    }
  }

  Future<ChatModel> sendChat(Map<String, dynamic> body) async {
    try {
      final response = await apiServices.post(
        endPoint: ApiEndpoints.sendChat,
        body: body,
      );
      return ChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to send chat: $e');
    }
  }

  Future<SearchChatModel> searchChat(String query) async {
    try {
      final response = await apiServices.get(
        endPoint: '${ApiEndpoints.searchChat}?search=$query',
      );
      return SearchChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to search chat: $e');
    }
  }
}
