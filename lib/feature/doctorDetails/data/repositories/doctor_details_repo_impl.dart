import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/models/doctor_detail_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/doctor_details_repo.dart';

class DoctorDetailsRepoImpl implements DoctorDetailsRepo {
  final DoctorDetailsRemoteDataSource remoteDataSource;

  DoctorDetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DoctorDetailsEntity>> fetchDoctorDetails(int doctorId) async {
    try {
      final result = await remoteDataSource.fetchDoctorDetails(doctorId);
      if (result is DoctorDetailsModel) {
        for (var slot in result.availableSlots) {
          print('Repository: Slot - Date: ${slot.dateTime}, Time: ${slot.startTime}-${slot.endTime}, Booked: ${slot.isBooked}');
        }
      } else {
        print('Repository: Result is not DoctorDetailsModel!');
      }
      return Right(result);
    } on ServerException catch (e) {
      print('Repository: ServerException - ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

