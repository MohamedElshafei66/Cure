
import '../../data/models/search_chat_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<DoctorModel> doctors;
  SearchLoaded(this.doctors);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}
