import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
=======
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/data/favourites_repository_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
<<<<<<< HEAD
  final SecureStorageService? secureStorage;

  FavouritesCubit({this.secureStorage}) : super(FavouriteInitial());
=======
  FavouritesCubit() : super(FavouriteInitial());
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab

  Future<void> fetchFavourites() async {
    emit(FavouriteLoading());
    try {
      final favourites = await FavouritesRepositoryImpl(
<<<<<<< HEAD
        ApiServices(secureStorage: secureStorage),
=======
        ApiServices(token: SharedData.testToken),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      ).getFavourites();

      if (favourites.isEmpty) {
        emit(FavouriteEmpty());
      } else {
        emit(FavouriteLoaded(favourites));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleDoctorFavourite(DoctorModel doctor) async {
    try {
      await FavouritesRepositoryImpl(
<<<<<<< HEAD
        ApiServices(secureStorage: secureStorage),
=======
        ApiServices(token: SharedData.testToken),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      ).toggleFavourite(doctor);

      await fetchFavourites();
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
