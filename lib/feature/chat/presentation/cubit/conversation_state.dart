import '../../data/models/chat_model.dart';

abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<MessageDTO> messages;
  ConversationLoaded(this.messages);
}

class ConversationSending extends ConversationState {
  final List<MessageDTO> messages;
  ConversationSending(this.messages);
}

class ConversationSent extends ConversationState {
  final List<MessageDTO> messages;
  ConversationSent(this.messages);
}

class ConversationError extends ConversationState {
  final String message;
  final List<MessageDTO> messages;
  ConversationError(this.message, {this.messages = const []});
}
