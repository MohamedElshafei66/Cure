import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/reschedule_entity.dart';
import '../../domain/repositories/booking_repo.dart';
import '../data_sources/booking_search_remote_data_source.dart';

class BookingRepoImpl implements BookingRepo {
  final BookingSearchRemoteDataSource remoteDataSource;

  BookingRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings({String? fromDate}) async {
    try {
      // Use current date if fromDate is not provided
      String formattedDate;
      if (fromDate != null) {
        formattedDate = fromDate;
      } else {
        final now = DateTime.now();
        // Format date as YYYY-M-D (e.g., 2024-1-15) - without leading zeros
        formattedDate = '${now.year}-${now.month}-${now.day}';
      }
      
      print('Repository: Fetching bookings for date: $formattedDate');
      final result = await remoteDataSource.searchBookings(formattedDate);
      print('Repository: Success - Got ${result.length} bookings');
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

  @override
  Future<Either<Failure, Unit>> cancelBooking(String bookingId) async {
    try {
      print('Repository: Cancelling booking with ID: $bookingId');
      final result = await remoteDataSource.cancelBooking(bookingId);
      print('Repository: Success - Booking cancelled');
      print('  - Booking ID: ${result.bookingId}');
      print('  - Status: ${result.bookingStatus}');
      return const Right(unit);
    } on ServerException catch (e) {
      print('Repository: ServerException - ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      print('Repository: Unexpected error - $e');
      print('Stack trace: $stackTrace');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> feedbackBooking(String bookingId) {
    // TODO: Implement feedback booking
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RescheduleEntity>> rescheduleBooking(RescheduleEntity rescheduleEntity) async {
    try {
      // Format the date and time into ISO 8601 format
      final dateTime = DateTime(
        rescheduleEntity.availableDate.year,
        rescheduleEntity.availableDate.month,
        rescheduleEntity.availableDate.day,
      );
      
      // Parse time string (assuming format like "15:00" or "3:00 PM")
      final timeParts = rescheduleEntity.availableTime.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = timeParts.length > 1 ? int.parse(timeParts[1].split(' ')[0]) : 0;
      
      // Handle PM/AM if present
      if (rescheduleEntity.availableTime.toUpperCase().contains('PM') && hour != 12) {
        hour += 12;
      } else if (rescheduleEntity.availableTime.toUpperCase().contains('AM') && hour == 12) {
        hour = 0;
      }
      
      final appointmentDateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        hour,
        minute,
      );
      
      // Format as "yyyy-MM-ddTHH:mm:ss" to match API expectation
      final dateTimeString = '${appointmentDateTime.year.toString().padLeft(4, '0')}-'
          '${appointmentDateTime.month.toString().padLeft(2, '0')}-'
          '${appointmentDateTime.day.toString().padLeft(2, '0')}T'
          '${appointmentDateTime.hour.toString().padLeft(2, '0')}:'
          '${appointmentDateTime.minute.toString().padLeft(2, '0')}:'
          '${appointmentDateTime.second.toString().padLeft(2, '0')}';
      
      print('Repository: Rescheduling booking with ID: ${rescheduleEntity.bookingId}');
      print('  - New date: ${rescheduleEntity.availableDate}');
      print('  - New time: ${rescheduleEntity.availableTime}');
      print('  - Formatted DateTime: $dateTimeString');
      
      final result = await remoteDataSource.rescheduleBooking(
        rescheduleEntity.bookingId,
        dateTimeString,
      );
      
      print('Repository: Success - Booking rescheduled');
      print('  - Booking ID: ${result.bookingId}');
      print('  - Status: ${result.bookingStatus}');
      print('  - New Appointment: ${result.dateTimeBooking}');
      
      // Create updated RescheduleEntity from result
      final updatedRescheduleEntity = RescheduleEntity(
        rescheduleEntity.doctorInfo,
        result.dateTimeBooking,
        rescheduleEntity.availableTime, // Keep the time string format
        rescheduleEntity.statusDoctor,
        result.bookingId,
      );
      
      return Right(updatedRescheduleEntity);
    } on ServerException catch (e) {
      print('Repository: ServerException - ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      print('Repository: Unexpected error - $e');
      print('Stack trace: $stackTrace');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> supportBooking(String bookingId) {
    // TODO: Implement support booking
    throw UnimplementedError();
  }
}

