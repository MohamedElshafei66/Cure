import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/doctor_info_entity.dart';

class RescheduleEntity{
  final DoctorInfoEntity doctorInfo;
  final String bookingId;
  final DateTime availableDate;
  final String availableTime;
  final String statusDoctor;

  RescheduleEntity(
      this.doctorInfo,
      this.availableDate,
      this.availableTime,
      this.statusDoctor,
      this.bookingId
      );

}