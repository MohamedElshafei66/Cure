import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';

abstract class FavouritesRepository {
  Future<List<DoctorModel>> getFavourites();
  Future<void> toggleFavourite(DoctorModel doctor);
}
