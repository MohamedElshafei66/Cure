import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entites/booking_entity.dart';
import '../repositories/booking_repo.dart';

class CreateBookingUseCase implements UseCase<BookingEntity, CreateBookingParams> {
  final BookingRepo bookingRepo;

  CreateBookingUseCase(this.bookingRepo);

  @override
  Future<Either<Failure, BookingEntity>> call(CreateBookingParams params) async {
    return await bookingRepo.createBooking(
      doctorId: params.doctorId,
      slotId: params.slotId,
      amount: params.amount,
      payment: params.payment,
      status: params.status,
      appointmentAt: params.appointmentAt,
    );
  }
}

class CreateBookingParams {
  final int doctorId;
  final int slotId;
  final double amount;
  final int payment;
  final int status;
  final DateTime appointmentAt;

  CreateBookingParams({
    required this.doctorId,
    required this.slotId,
    required this.amount,
    required this.payment,
    required this.status,
    required this.appointmentAt,
  });
}

