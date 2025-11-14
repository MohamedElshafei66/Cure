import 'package:round_7_mobile_cure_team3/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/models/search_chat_model.dart';

import '../../data/models/chat_model.dart';

abstract class ChatRepository {

  Future<ChatModel> getChatsList();
  Future<ChatModel> startChat(Map<String, dynamic> body);
  Future<ChatModel> sendChat(ChatModel chatModel);
  Future<SearchChatModel> searchChat(String query);
}
