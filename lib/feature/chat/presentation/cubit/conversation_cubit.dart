import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/ChatRepositoryImp.dart';
import '../../domain/repositories/ChatRepository.dart';
import 'conversation_state.dart';
import '../../data/models/chat_model.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepository chatRepository;

  ConversationCubit(this.chatRepository) : super(ConversationInitial());

  Future<void> sendMessage(String chatId, String receiverId, String message) async {
    emit(ConversationSending());
    try {
      final chat = ChatModel(
        success: true,
        message: message,
        data: null,
      );

      final response = await chatRepository.sendChat(chat);
      emit(ConversationSent(response));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }
}
