import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/history_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<DoctorModel> doctors;

  SearchLoaded(this.doctors);
}

class SearchFailed extends SearchState {
  final String message;
  SearchFailed(this.message);
}

class SearchEmpty extends SearchState {}

class SearchHistoryLoaded extends SearchState {
  final List<HistoryModel> history;
  SearchHistoryLoaded(this.history);
}
