import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;

  DoctorLoaded(this.doctors);
}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}

class NearestDoctorLoading extends DoctorState {}

class NearestDoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  NearestDoctorLoaded(this.doctors);
}
