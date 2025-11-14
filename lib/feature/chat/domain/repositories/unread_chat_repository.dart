import '../../data/models/unread_chat_model.dart';

abstract class UnreadChatRepository {
  Future<UnreadChatModel> getUnreadChats();
}
