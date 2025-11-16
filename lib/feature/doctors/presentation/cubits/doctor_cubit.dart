import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/repositories/doctor_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepoImpl doctorRepo;

  DoctorCubit({required AuthProvider authProvider})
      : doctorRepo = DoctorRepoImpl(ApiServices(authProvider: authProvider)),
        super(DoctorInitial());

  Future<void> fetchAllDoctors() async {
    emit(DoctorLoading());
    try {
      final doctors = await doctorRepo.getAllDoctors();
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }

  Future<void> fetchNearestDoctors() async {
    emit(NearestDoctorLoading());
    try {
      final doctors = await doctorRepo.getNearestDoctors();
      emit(NearestDoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}
