import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_model.dart';
import '../models/search_chat_model.dart';

class ChatRepositoryImpl {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  Future<ChatModel> getChatsList() async {
    return await remoteDataSource.getChatsList();
  }

  Future<ChatModel> startChat(Map<String, dynamic> body) async {
    return await remoteDataSource.startChat(body);
  }

  Future<ChatModel> sendChat(ChatModel chat) async {
    return await remoteDataSource.sendChat(chat.toJson());
  }


}
