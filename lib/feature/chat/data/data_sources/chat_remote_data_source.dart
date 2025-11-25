import '../../../../core/constants/auth_provider.dart';
import '../models/chat_model.dart';
import '../models/search_chat_model.dart';
import '../../../../core/network/api_services.dart';
import '../../../../core/network/api_endpoints.dart';

class ChatRemoteDataSource {
  final ApiServices apiServices;

  ChatRemoteDataSource({required AuthProvider authProvider})
    : apiServices = ApiServices(authProvider: authProvider);

  Future<ChatModel> getChatsList() async {
    try {
      final response = await apiServices.get(endPoint: ApiEndpoints.chatsList);
      return ChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load chats list: $e');
    }
  }

  Future<ChatListModel> getChatsListMultiple() async {
    try {
      print('📥 Fetching chats list from API...');
      print('   Endpoint: ${ApiEndpoints.chatsList}');
      final response = await apiServices.get(endPoint: ApiEndpoints.chatsList);
      print('✅ Chats list received');
      print('   Response type: ${response.runtimeType}');
      if (response is Map<String, dynamic>) {
        print('   Response keys: ${response.keys.toList()}');
      }

      // Log the full response structure for debugging
      if (response is Map && response.containsKey('data')) {
        final data = response['data'];
        print('   Data type: ${data.runtimeType}');
        if (data is Map) {
          print('   Data keys: ${data.keys.toList()}');
          if (data.containsKey('chatListDTOS')) {
            print(
              '   chatListDTOS length: ${(data['chatListDTOS'] as List?)?.length ?? 0}',
            );
          }
          if (data.containsKey('doctorsListDTO')) {
            print(
              '   doctorsListDTO length: ${(data['doctorsListDTO'] as List?)?.length ?? 0}',
            );
          }
        }
      }

      return ChatListModel.fromJson(response);
    } catch (e) {
      print('❌ Failed to load chats list: $e');
      throw Exception('Failed to load chats list: $e');
    }
  }

  Future<ChatModel> startChat(Map<String, dynamic> body) async {
    try {
      // Extract receiverId from body
      final receiverId = body['receiverId'] ?? '';

      print('🔵 Starting chat with receiverId: $receiverId');

      // Try POST method as per API documentation
      final response = await apiServices.post(
        endPoint: ApiEndpoints.startChat,
        body: {'receiverId': receiverId},
      );

      print('✅ Start chat response: $response');
      return ChatModel.fromJson(response);
    } catch (e) {
      print('❌ Failed to start chat: $e');
      // If 405 error, the chat might not exist yet - return empty chat
      if (e.toString().contains('405') || e.toString().contains('404')) {
        return ChatModel(
          success: false,
          message: 'Chat not found - will create on first message',
          data: null,
        );
      }
      throw Exception('Failed to start chat: $e');
    }
  }

  Future<ChatModel> sendChat(Map<String, dynamic> body) async {
    try {
      // Extract the message data from the body
      Map<String, dynamic> messageBody = {};

      if (body['data'] != null && body['data']['messageListDTO'] != null) {
        final messages = body['data']['messageListDTO'] as List;
        if (messages.isNotEmpty) {
          messageBody = messages[0] as Map<String, dynamic>;
        }
      }

      final response = await apiServices.post(
        endPoint: ApiEndpoints.sendChat,
        body: messageBody,
      );
      return ChatModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to send chat: $e');
    }
  }

  Future<ChatModel> sendChatMessage(Map<String, dynamic> messageData) async {
    try {
      print('📤 Sending message with data: $messageData');

      // Send message directly without complex extraction
      final response = await apiServices.post(
        endPoint: ApiEndpoints.sendChat,
        body: messageData,
      );

      print('✅ Message sent successfully: $response');
      return ChatModel.fromJson(response);
    } catch (e) {
      print('❌ Send message error: $e');
      print('📝 Attempted payload: $messageData');
      throw Exception('Failed to send message: $e');
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
