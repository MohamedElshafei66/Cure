import '../../domain/repositories/unread_chat_repository.dart';
import '../data_sources/unread_chat_remote_data_source.dart';
import '../models/unread_chat_model.dart';

class UnreadChatRepositoryImpl implements UnreadChatRepository {
  final UnreadChatRemoteDataSource remoteDataSource;

  UnreadChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<UnreadChatModel> getUnreadChats() async {
    try {
      return await remoteDataSource.getUnreadChats();
    } catch (e) {
      throw Exception("Repository Error (UnreadChats): $e");
    }
  }
}
