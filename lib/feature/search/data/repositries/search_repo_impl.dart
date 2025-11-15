import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/history_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/domain/repositries/search_repository.dart';

class SearchRepoImpl implements SearchRepository {
  final ApiServices apiServices;

  SearchRepoImpl(this.apiServices);

  @override
  Future<List<DoctorModel>> searchDoctors(searchModel) async {
    final response = await apiServices.post(
      endPoint: ApiEndpoints.searchDoctor,
      body: searchModel.toJson(),
    );
    final data = response['data'];
    if (data is List) {
      return data.map((item) => DoctorModel.fromJson(item)).toList();
    } else if (data != null && data['doctors'] != null) {
      final doctorsList = data['doctors'] as List;
      return doctorsList.map((item) => DoctorModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<List<HistoryModel>> getHistory() async {
    final response = await apiServices.get(endPoint: ApiEndpoints.getHistory);
    final data = response['data'];
    if (data is List) {
      return data.map((item) => HistoryModel.fromJson(item)).toList();
    }
    return [];
  }

  @override
  Future<List<DoctorModel>> searchByLocation(position) async {
    final endPoint =
        '${ApiEndpoints.searchByLocation}?latitude=${position.latitude}&longitude=${position.longitude}&radiusKm=15';

    final response = await apiServices.get(endPoint: endPoint);
    final data = response['data'];

    if (data is List) {
      return data.map((item) => DoctorModel.fromJson(item)).toList();
    } else if (data != null && data['doctors'] != null) {
      final doctorsList = data['doctors'] as List;
      return doctorsList.map((item) => DoctorModel.fromJson(item)).toList();
    }

    return [];
  }
}
