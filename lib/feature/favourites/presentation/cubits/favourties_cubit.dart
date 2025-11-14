import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/data/favourites_repository_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouriteInitial());

  Future<void> fetchFavourites() async {
    emit(FavouriteLoading());
    try {
      final favourites = await FavouritesRepositoryImpl(
        ApiServices(token: SharedData.testToken),
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
        ApiServices(token: SharedData.testToken),
      ).toggleFavourite(doctor);

      await fetchFavourites();
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}
