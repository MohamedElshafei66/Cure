import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/cubit/search_state.dart';
import '../../domain/repositories/ChatRepository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ChatRepository chatRepository;

  SearchCubit(this.chatRepository) : super(SearchInitial());

  Future<void> searchChats(String query) async {
    emit(SearchLoading());
    try {
      final result = await chatRepository.searchChat(query);
      emit(SearchLoaded(result.data.doctorsListDTO));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
