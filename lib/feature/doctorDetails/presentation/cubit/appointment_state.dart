part of 'appointment_cubit.dart';

class AppointmentState extends Equatable {
  final DoctorDetailsEntity? doctorDetails;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String? paymentMethod;
  final List<AvailableSlotModel> availableSlots;

  const AppointmentState({
    this.doctorDetails,
    this.selectedDate,
    this.selectedTime,
    this.paymentMethod,
    this.availableSlots = const [],
  });

  AppointmentState copyWith({
    DoctorDetailsEntity? doctorDetails,
    DateTime? selectedDate,
    String? selectedTime,
    String? paymentMethod,
    List<AvailableSlotModel>? availableSlots,
  }) {
    return AppointmentState(
      doctorDetails: doctorDetails ?? this.doctorDetails,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      availableSlots: availableSlots ?? this.availableSlots,
    );
  }

  @override
  List<Object?> get props => [doctorDetails, selectedDate, selectedTime, paymentMethod, availableSlots];
}

class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

