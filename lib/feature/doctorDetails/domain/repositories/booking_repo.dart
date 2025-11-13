import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entites/booking_entity.dart';

abstract class BookingRepo {
  Future<Either<Failure, BookingEntity>> createBooking({
    required int doctorId,
    required int slotId,
    required double amount,
    required int payment,
    required int status,
    required DateTime appointmentAt,
  });
}

