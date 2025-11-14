import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/booking_repo.dart';
import '../../domain/entites/booking_entity.dart';
import '../data_sources/booking_remote_data_source.dart';

class BookingRepoImpl implements BookingRepo {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BookingEntity>> createBooking({
    required int doctorId,
    required int slotId,
    required double amount,
    required int payment,
    required int status,
    required DateTime appointmentAt,
  }) async {
    try {
      final result = await remoteDataSource.createBooking(
        doctorId: doctorId,
        slotId: slotId,
        amount: amount,
        payment: payment,
        status: status,
        appointmentAt: appointmentAt,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

