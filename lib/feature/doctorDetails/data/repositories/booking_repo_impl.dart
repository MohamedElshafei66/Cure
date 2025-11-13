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
      print('========================================');
      print('REPOSITORY: Creating booking');
      print('========================================');
      print('Repository: Calling remote data source...');
      final result = await remoteDataSource.createBooking(
        doctorId: doctorId,
        slotId: slotId,
        amount: amount,
        payment: payment,
        status: status,
        appointmentAt: appointmentAt,
      );
      print('========================================');
      print('REPOSITORY: Success');
      print('========================================');
      print('Repository: Booking created successfully');
      print('  - Booking ID: ${result.id}');
      print('  - Doctor ID: ${result.doctorId}');
      print('  - Doctor Name: ${result.doctorName}');
      print('  - Patient ID: ${result.patientId}');
      print('  - Patient Name: ${result.patientName}');
      print('  - Payment: ${result.payment}');
      print('  - Status: ${result.status}');
      print('  - Payment URL: ${result.paymentUrl ?? "N/A"}');
      print('  - Appointment At: ${result.appointmentAt}');
      print('========================================');
      return Right(result);
    } on ServerException catch (e) {
      print('Repository: ServerException - ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      print('Repository: Unexpected error - $e');
      print('Stack trace: $stackTrace');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

