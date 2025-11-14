import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/history_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/domain/repositries/search_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository searchRepository;

  SearchCubit(this.searchRepository) : super(SearchInitial());

  Future<void> searchDoctors(SearchModel searchModel) async {
    emit(SearchLoading());
    try {
      final result = await searchRepository.searchDoctors(searchModel);
      if (result.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(result));
      }
    } catch (e) {
      emit(SearchFailed(e.toString()));
    }
  }

  Future<void> fetchHistory() async {
    try {
      final List<HistoryModel> historyList = await searchRepository
          .getHistory();

      final seen = <String>{};
      final uniqueHistory = historyList.reversed
          .where((item) => seen.add(item.keyword)) // adjust key if different
          .toList()
          .reversed
          .toList();

      final List<HistoryModel> lastFour = uniqueHistory.length > 4
          ? uniqueHistory.sublist(uniqueHistory.length - 4)
          : uniqueHistory;

      emit(SearchHistoryLoaded(lastFour));
    } catch (e) {
      emit(SearchFailed('Failed to load history: $e'));
    }
  }

  Future<void> searchWithLocation(Position position) async {
    emit(SearchLoading());
    try {
      final result = await searchRepository.searchByLocation(position);
      if (result.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(result));
      }
    } catch (e) {
      emit(SearchFailed(e.toString()));
    }
  }

  void reset() {
    emit(SearchInitial());
  }
}
