import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/booking_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/doctor_info_entity.dart';

class BookingSearchModel extends BookingEntity {
  BookingSearchModel({
    required DoctorInfoEntity doctorInfo,
    required String bookingId,
    required String bookingStatus,
    required DateTime dateTimeBooking,
    required this.patientId,
    required this.patientName,
    required this.payment,
    required this.paymentUrl,
  }) : super(doctorInfo, bookingId, bookingStatus, dateTimeBooking);

  final int patientId;
  final String patientName;
  final String payment;
  final String paymentUrl;

  factory BookingSearchModel.fromJson(Map<String, dynamic> json) {
    return BookingSearchModel(
      doctorInfo: DoctorInfoEntity(
        json['doctorId'].toString(),
        json['doctorName'] ?? '',
        json['doctorImg'] ?? '',
        json['doctorSpeciality'] ?? '',
        '', // API doesn't provide location in this response
      ),
      bookingId: json['id'].toString(),
      bookingStatus: json['status'] ?? '',
      dateTimeBooking: DateTime.parse(json['appointmentAt']),
      patientId: json['patientId'] ?? 0,
      patientName: json['patientName'] ?? '',
      payment: json['payment'] ?? '',
      paymentUrl: json['paymentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': int.parse(bookingId),
      'doctorId': int.parse(doctorInfo.doctorId),
      'doctorName': doctorInfo.doctorName,
      'doctorSpeciality': doctorInfo.doctorSpecialty,
      'doctorImg': doctorInfo.doctorImage,
      'patientId': patientId,
      'patientName': patientName,
      'payment': payment,
      'status': bookingStatus,
      'paymentUrl': paymentUrl,
      'appointmentAt': dateTimeBooking.toIso8601String(),
    };
  }
}

