import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;
  int? currentDoctorId;

  DoctorDetailsCubit({required this.getDoctorDetailsUseCase})
      : super(DoctorDetailsInitial());

  Future<void> fetchDoctorDetails(int doctorId) async {
    currentDoctorId = doctorId;
    try {
      print('cubit: Fetching doctor details for ID: $doctorId');
      emit(DoctorDetailsLoading());
      final result = await getDoctorDetailsUseCase(doctorId);
      result.fold(
        (failure) {
          print('cubit: Error - ${failure.message}');
          emit(DoctorDetailsError(failure.message));
        },
        (doctorDetails) {
          print('cubit: Success - Doctor name: ${doctorDetails.doctorName}');
          emit(DoctorDetailsLoaded(doctorDetails));
        },
      );
    } catch (e, stackTrace) {
      print('cubit: Exception - $e');
      print('Stack trace: $stackTrace');
      emit(DoctorDetailsError('Failed to fetch doctor details: ${e.toString()}'));
    }
  }
}

