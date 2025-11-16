import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';

abstract class FavouritesState {}

class FavouriteLoading extends FavouritesState {}

class FavouriteLoaded extends FavouritesState {
  final List<DoctorModel>? doctors;
  FavouriteLoaded(this.doctors);
}

class FavouriteError extends FavouritesState {
  final String error;
  FavouriteError(this.error);
}

class FavouriteEmpty extends FavouritesState {}

class FavouriteInitial extends FavouritesState {}
