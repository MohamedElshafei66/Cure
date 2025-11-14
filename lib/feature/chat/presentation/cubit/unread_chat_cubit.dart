import 'package:flutter_bloc/flutter_bloc.dart';
import 'unread_chat_state.dart';
import '../../domain/repositories/unread_chat_repository.dart';

class UnreadChatCubit extends Cubit<UnreadChatState> {
  final UnreadChatRepository repository;

  UnreadChatCubit(this.repository) : super(UnreadChatInitial());

  Future<void> fetchUnreadChats() async {
    emit(UnreadChatLoading());
    try {
      final result = await repository.getUnreadChats();
      emit(UnreadChatLoaded(result.data!.doctorsListDTO));
    } catch (e) {
      emit(UnreadChatError(e.toString()));
    }
  }
}
