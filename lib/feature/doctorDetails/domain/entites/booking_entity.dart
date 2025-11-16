class BookingEntity {
  final int id;
  final int doctorId;
  final String doctorName;
  final String doctorSpeciality;
  final String doctorImg;
  final int patientId;
  final String patientName;
  final String payment;
  final String status;
  final String? paymentUrl;
  final DateTime appointmentAt;

  BookingEntity({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpeciality,
    required this.doctorImg,
    required this.patientId,
    required this.patientName,
    required this.payment,
    required this.status,
    this.paymentUrl,
    required this.appointmentAt,
  });
}

