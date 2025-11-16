import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/booking_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/repositories/booking_repo.dart';

class GetBookingParams {
  final String? fromDate;
  GetBookingParams({this.fromDate});
}

class GetBookingUseCase extends UseCase<List<BookingEntity>, GetBookingParams>{
  final BookingRepo bookingRepo;
  GetBookingUseCase(this.bookingRepo);
  @override
  Future<Either<Failure, List<BookingEntity>>> call(GetBookingParams param)async{
    return await bookingRepo.getBookings(fromDate: param.fromDate);
  }

}