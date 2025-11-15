import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';

abstract class DoctorRepository {
  Future<List<DoctorModel>> getAllDoctors();
  Future<List<DoctorModel>> getNearestDoctors();
}
