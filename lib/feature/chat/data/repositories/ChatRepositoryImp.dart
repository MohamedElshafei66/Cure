import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_model.dart';
import '../models/search_chat_model.dart';
import '../../domain/repositories/ChatRepository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ChatModel> getChatsList() async {
    return await remoteDataSource.getChatsList();
  }

  @override
  Future<ChatModel> startChat(Map<String, dynamic> body) async {
    return await remoteDataSource.startChat(body);
  }

  @override
  Future<ChatModel> sendChat(ChatModel chat) async {
    return await remoteDataSource.sendChat(chat.toJson());
  }

  @override
  Future<SearchChatModel> searchChat(String query) async {
    return await remoteDataSource.searchChat(query);
  }
}
