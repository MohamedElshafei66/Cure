import '../../data/models/chat_model.dart';

abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationSending extends ConversationState {}

class ConversationSent extends ConversationState {
  final ChatModel chatModel;
  ConversationSent(this.chatModel);
}

class ConversationError extends ConversationState {
  final String message;
  ConversationError(this.message);
}
