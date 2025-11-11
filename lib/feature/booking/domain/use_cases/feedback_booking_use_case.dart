import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/booking_repo.dart';

class FeedbackBookingUseCase extends UseCase<Unit,String>{
  final BookingRepo bookingRepo;
  FeedbackBookingUseCase(this.bookingRepo);

  @override
  Future<Either<Failure, Unit>> call(String bookingId)async{
    return await bookingRepo.feedbackBooking(bookingId);
  }



}