import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/ChatRepository.dart';
import 'conversation_state.dart';
import '../../data/models/chat_model.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepository chatRepository;
  List<MessageDTO> _messages = [];

  ConversationCubit(this.chatRepository) : super(ConversationInitial());

  Future<void> loadMessages(String chatId, String receiverId) async {
    emit(ConversationLoading());
    try {
      // Skip loading if receiverId is empty
      if (receiverId.isEmpty) {
        _messages = [];
        emit(ConversationLoaded(_messages));
        return;
      }

      // Try to start/get chat with the receiver
      final body = {'receiverId': receiverId};
      final response = await chatRepository.startChat(body);

      if (response.success && response.data != null) {
        _messages = response.data!.messageList;
        emit(ConversationLoaded(_messages));
      } else {
        // No existing chat, start with empty messages
        _messages = [];
        emit(ConversationLoaded(_messages));
      }
    } catch (e) {
      print('Error loading messages: $e');
      // For any error (404, 405, etc), just start with empty messages
      // This allows starting new conversations
      _messages = [];
      emit(ConversationLoaded(_messages));
    }
  }

  Future<void> sendMessage(
    String chatId,
    String receiverId,
    String message,
  ) async {
    if (message.trim().isEmpty) return;

    // Add message optimistically to UI
    final newMessage = MessageDTO(
      message: message,
      senderId: 'me', // Will be set by backend
      receiverId: receiverId,
    );

    final updatedMessages = [..._messages, newMessage];
    emit(ConversationSending(updatedMessages));

    try {
      // Send message with correct field names matching API
      final messageBody = {
        'chatId': chatId.isNotEmpty ? chatId : '0',
        'ReceiverId': receiverId, // Capital R as per API
        'Content': message, // 'Content' not 'message'
      };

      final response = await chatRepository.sendChatMessage(messageBody);

      if (response.success) {
        // Reload messages to get the actual message from server
        await loadMessages(chatId, receiverId);
      } else {
        _messages = updatedMessages;
        emit(ConversationSent(updatedMessages));
      }
    } catch (e) {
      print('Error sending message: $e');
      // Keep the message in the list even on error
      _messages = updatedMessages;
      emit(
        ConversationError(
          'Failed to send message: ${e.toString()}',
          messages: _messages,
        ),
      );
    }
  }
}
