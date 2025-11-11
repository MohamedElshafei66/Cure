import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/repositories/booking_repo.dart';

class SupportBookingUseCase extends UseCase<Unit,String>{
  final BookingRepo bookingRepo;
  SupportBookingUseCase(this.bookingRepo);

  @override
  Future<Either<Failure, Unit>> call(String bookingId)async{
    return await bookingRepo.supportBooking(bookingId);
  }

}