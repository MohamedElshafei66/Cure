import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import '../../data/models/chat_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatData> chats;

  const ChatLoaded(this.chats);

}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

}
