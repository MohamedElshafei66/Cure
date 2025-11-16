import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';

abstract class DoctorDetailsRepo{
  Future<Either<Failure,DoctorDetailsEntity>> fetchDoctorDetails(int doctorId);
}