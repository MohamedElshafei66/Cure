import '../../domain/entites/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.id,
    required super.doctorId,
    required super.doctorName,
    required super.doctorSpeciality,
    required super.doctorImg,
    required super.patientId,
    required super.patientName,
    required super.payment,
    required super.status,
    super.paymentUrl,
    required super.appointmentAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as int,
      doctorId: json['doctorId'] as int,
      doctorName: json['doctorName'] as String,
      doctorSpeciality: json['doctorSpeciality'] as String,
      doctorImg: json['doctorImg'] as String,
      patientId: json['patientId'] as int,
      patientName: json['patientName'] as String,
      payment: json['payment'] as String,
      status: json['status'] as String,
      paymentUrl: json['paymentUrl'] as String?,
      appointmentAt: DateTime.parse(json['appointmentAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpeciality': doctorSpeciality,
      'doctorImg': doctorImg,
      'patientId': patientId,
      'patientName': patientName,
      'payment': payment,
      'status': status,
      'paymentUrl': paymentUrl,
      'appointmentAt': appointmentAt.toIso8601String(),
    };
  }
}

