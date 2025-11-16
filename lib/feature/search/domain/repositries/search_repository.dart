import 'package:geolocator/geolocator.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/history_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';

abstract class SearchRepository {
  Future<List<DoctorModel>> searchDoctors(SearchModel searchModel);
  Future<List<HistoryModel>> getHistory();
  Future<List<DoctorModel>> searchByLocation(Position position);
}
