import 'package:round_7_mobile_cure_team3/feature/home/data/models/specialist_model.dart';

abstract class SpecialistState {}

class SpecialistInitial extends SpecialistState {}

class SpecialistLoading extends SpecialistState {}

class SpecialistLoaded extends SpecialistState {
  final List<SpecialistModel> specialists;
  SpecialistLoaded(this.specialists);
}

class SpecialistError extends SpecialistState {
  final String message;
  SpecialistError(this.message);
}
