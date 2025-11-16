import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart' show DoctorDetailsEntity;

class AppointmentEntity{
  final DoctorDetailsEntity doctorInfo;
  final String doctorId;
  final DateTime availableDate;
  final String availableTime;
  final String statusDoctor;
  final num doctorPrice;

  AppointmentEntity(
      this.doctorInfo,
      this.doctorId,
      this.availableDate,
      this.availableTime,
      this.statusDoctor,
      this.doctorPrice,
      );
}