import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/doctor_info_entity.dart';

class BookingEntity{
  final DoctorInfoEntity doctorInfo;
  final String bookingId;
  final DateTime dateTimeBooking;
  final String bookingStatus;

  BookingEntity(
      this.doctorInfo,
      this.bookingId,
      this.bookingStatus,
      this.dateTimeBooking
      );
}