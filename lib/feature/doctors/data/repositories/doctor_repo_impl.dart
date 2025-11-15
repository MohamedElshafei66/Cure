import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/domain/repositories/doctor_repository.dart';

class DoctorRepoImpl implements DoctorRepository {
  final ApiServices apiServices;

  DoctorRepoImpl(this.apiServices);

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    final response = await apiServices.get(
      endPoint: ApiEndpoints.getAllDoctors,
    );

    final List<dynamic> doctorsJson = response['data'] as List<dynamic>;

    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }

  @override
  Future<List<DoctorModel>> getNearestDoctors() async {
    final response = await apiServices.get(
      endPoint: ApiEndpoints.getNearestDoctors,
    );
    if (response == null || response['data'] == null) {
      return [];
    }

    final List<dynamic> doctorsJson = response['data'] as List<dynamic>;

    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }
}
