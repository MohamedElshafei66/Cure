import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/booking_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/reschedule_entity.dart';

abstract class BookingRepo{
  Future<Either<Failure,List<BookingEntity>>> getBookings();
  Future<Either<Failure, Unit>> cancelBooking(String bookingId);
  Future<Either<Failure, RescheduleEntity>> rescheduleBooking(RescheduleEntity rescheduleEntity);
  Future<Either<Failure, Unit>> feedbackBooking(String bookingId);
  Future<Either<Failure, Unit>> supportBooking(String bookingId);




}