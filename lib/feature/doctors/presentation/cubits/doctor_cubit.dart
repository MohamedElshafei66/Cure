import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/repositories/doctor_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  Future<void> fetchAllDoctors() async {
    emit(DoctorLoading());
    try {
      final doctors = await DoctorRepoImpl(
        ApiServices(token: SharedData.token),
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
        ApiServices(token: SharedData.token),
      ).getNearestDoctors();
      emit(NearestDoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}