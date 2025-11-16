import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';

class PaymentEntity{
  final DoctorDetailsEntity doctorInfo;
  final String appointmentId;
  final String payMethod;
  final String payStatus;
  final num priceDoctor;

  PaymentEntity(
      this.doctorInfo,
      this.appointmentId,
      this.payMethod,
      this.payStatus,
      this.priceDoctor
      );
}