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
      ChatModel chatModel = await repository.getChatsList();
      emit(ChatLoaded(chatModel.data != null ? [chatModel.data!] : []));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }


}
