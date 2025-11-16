import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/doctor_details_repo.dart';

class GetDoctorDetailsUseCase implements UseCase<DoctorDetailsEntity, int> {
  final DoctorDetailsRepo doctorDetailsRepo;

  GetDoctorDetailsUseCase(this.doctorDetailsRepo);

  @override
  Future<Either<Failure, DoctorDetailsEntity>> call(int doctorId) async {
    return await doctorDetailsRepo.fetchDoctorDetails(doctorId);
  }
}

