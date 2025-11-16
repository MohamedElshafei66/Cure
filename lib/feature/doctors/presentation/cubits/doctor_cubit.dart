import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
=======
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/repositories/doctor_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
<<<<<<< HEAD
  final SecureStorageService? secureStorage;

  DoctorCubit({this.secureStorage}) : super(DoctorInitial());
=======
  DoctorCubit() : super(DoctorInitial());
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab

  Future<void> fetchAllDoctors() async {
    emit(DoctorLoading());
    try {
      final doctors = await DoctorRepoImpl(
<<<<<<< HEAD
        ApiServices(secureStorage: secureStorage),
=======
        ApiServices(token: SharedData.testToken),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      ).getAllDoctors();
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }

  Future<void> fetchNearestDoctors() async {
    emit(NearestDoctorLoading());
    try {
      final doctors = await DoctorRepoImpl(
<<<<<<< HEAD
        ApiServices(secureStorage: secureStorage),
=======
        ApiServices(token: SharedData.testToken),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      ).getNearestDoctors();
      emit(NearestDoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}
