import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/reschedule_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/repositories/booking_repo.dart';

class RescheduleBookingUseCase extends UseCase<RescheduleEntity,RescheduleEntity>{
  final BookingRepo bookingRepo;
  RescheduleBookingUseCase(this.bookingRepo);

  @override
  Future<Either<Failure, RescheduleEntity>> call(RescheduleEntity rescheduleEntity)async{
    return await bookingRepo.rescheduleBooking(rescheduleEntity);
  }


}