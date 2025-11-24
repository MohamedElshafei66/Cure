import 'package:round_7_mobile_cure_team3/feature/home/data/models/specialist_model.dart';

abstract class SpecialistRepo {
  Future<List<SpecialistModel>> getSpecialists();
}
