import 'package:equatable/equatable.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';

abstract class FavouritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavouriteLoading extends FavouritesState {}

class FavouriteLoaded extends FavouritesState {
  final List<DoctorModel>? doctors;
  FavouriteLoaded(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class FavouriteError extends FavouritesState {
  final String error;
  FavouriteError(this.error);

  @override
  List<Object?> get props => [error];
}

class FavouriteEmpty extends FavouritesState {}

class FavouriteInitial extends FavouritesState {}
