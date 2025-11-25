import '../../data/repositories/ChatRepositoryImp.dart';
import '../../data/models/chat_model.dart';
import '../../domain/repositories/ChatRepository.dart';
import 'chats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepositoryImpl repository;

  ChatCubit(this.repository) : super(ChatInitial());

  Future<void> fetchChats() async {
    emit(ChatLoading());
    try {
      print('🔄 ChatCubit: Fetching chats...');
      ChatListModel chatListModel = await repository.getChatsListMultiple();

      print('✅ ChatCubit: Received ${chatListModel.chatListDTOS.length} chats');
      print('   - Unread messages: ${chatListModel.unReadMessagesCount}');
      print('   - Total records: ${chatListModel.pagination.totalRecords}');

      if (chatListModel.success) {
        // Use chatListDTOS which matches the API response structure
        emit(ChatLoaded(chatListModel.chatListDTOS));
      } else {
        emit(ChatError(chatListModel.message));
      }
    } catch (e) {
      print('❌ ChatCubit error: $e');
      emit(ChatError(e.toString()));
    }
  }
}
