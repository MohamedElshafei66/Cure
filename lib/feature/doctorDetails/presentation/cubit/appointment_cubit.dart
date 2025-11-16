import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/models/available_slot_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/models/doctor_detail_model.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/doctor_details_entity.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit() : super(AppointmentInitial());

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date, selectedTime: null));
  }

  void selectTime(String time) {
    emit(state.copyWith(selectedTime: time));
  }

  void selectPaymentMethod(String paymentMethod) {
    emit(state.copyWith(paymentMethod: paymentMethod));
  }

  void setDoctorDetails(DoctorDetailsEntity doctorDetails) {
    List<AvailableSlotModel> availableSlots = [];
    

    if (doctorDetails is DoctorDetailsModel) {
      availableSlots = doctorDetails.availableSlots;
      for (var slot in availableSlots) {
        print('Slot: ${slot.dateTime} - ${slot.startTime} to ${slot.endTime}, booked: ${slot.isBooked}');
      }
    } else {
      print('AppointmentCubit: doctorDetails is not a DoctorDetailsModel, type: ${doctorDetails.runtimeType}');
    }
    
    final currentState = state;
    emit(currentState.copyWith(
      doctorDetails: doctorDetails,
      availableSlots: availableSlots,
    ));
    
    // Set default payment method if not already set
    if (currentState.paymentMethod == null) {
      emit(currentState.copyWith(
        doctorDetails: doctorDetails,
        availableSlots: availableSlots,
        paymentMethod: 'Credit Card', // Default payment method
      ));
    }
  }

  void reset() {
    emit(AppointmentInitial());
  }
  
  // Get available dates from slots
  List<DateTime> getAvailableDates() {
    if (state.availableSlots.isEmpty) return [];
    final dates = state.availableSlots
        .map((slot) => DateTime(slot.dateTime.year, slot.dateTime.month, slot.dateTime.day))
        .toSet()
        .toList();
    dates.sort();
    return dates;
  }
  
  // Get available times for a specific date
  List<String> getAvailableTimesForDate(DateTime date) {
    if (state.availableSlots.isEmpty) {
      return [];
    }
    
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    final slotsForDate = state.availableSlots.where((slot) {
      final slotDate = DateTime(slot.dateTime.year, slot.dateTime.month, slot.dateTime.day);
      final isSameDate = slotDate.year == dateOnly.year &&
                        slotDate.month == dateOnly.month &&
                        slotDate.day == dateOnly.day;
      final isAvailable = isSameDate && !slot.isBooked;
      
      if (isSameDate) {
        print('Found slot: ${slot.startTime} - ${slot.endTime}, isBooked: ${slot.isBooked}');
      }
      
      return isAvailable;
    }).toList();
    
    print('Found ${slotsForDate.length} available slots for this date');
    
    // Format times (convert "10:00:00" to "10:00 AM")
    final formattedTimes = slotsForDate.map((slot) {
      final formatted = _formatTime(slot.startTime);
      print('Formatted time: ${slot.startTime} -> $formatted');
      return formatted;
    }).toList();
    
    // Remove duplicates and sort
    final uniqueTimes = formattedTimes.toSet().toList();
    uniqueTimes.sort();
    
    print('Final times to display: $uniqueTimes');
    return uniqueTimes;
  }
  
  String _formatTime(String timeString) {
    try {
      if (timeString.isEmpty) return '';
      
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minuteStr = parts[1];
        final minute = minuteStr.length >= 2 ? minuteStr.substring(0, 2) : minuteStr.padLeft(2, '0');
        
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        
        return '$displayHour:$minute $period';
      }
    } catch (e) {
      print('Error formatting time "$timeString": $e');
    }
    return timeString;
  }

  // Get selected slot ID based on selected date and time
  int? getSelectedSlotId() {
    if (state.selectedDate == null || state.selectedTime == null) {
      return null;
    }

    final dateOnly = DateTime(state.selectedDate!.year, state.selectedDate!.month, state.selectedDate!.day);
    
    // Convert selected time back to 24-hour format for matching
    final selectedTime24 = _convertTo24Hour(state.selectedTime!);
    
    final matchingSlot = state.availableSlots.firstWhere(
      (slot) {
        final slotDate = DateTime(slot.dateTime.year, slot.dateTime.month, slot.dateTime.day);
        final isSameDate = slotDate.year == dateOnly.year &&
                          slotDate.month == dateOnly.month &&
                          slotDate.day == dateOnly.day;
        final isSameTime = slot.startTime == selectedTime24;
        return isSameDate && isSameTime && !slot.isBooked;
      },
      orElse: () => throw Exception('No matching slot found'),
    );

    return matchingSlot.id;
  }

  String _convertTo24Hour(String time12Hour) {
    try {
      final parts = time12Hour.split(' ');
      if (parts.length == 2) {
        final timePart = parts[0];
        final period = parts[1].toUpperCase();
        final timeComponents = timePart.split(':');
        
        if (timeComponents.length == 2) {
          var hour = int.parse(timeComponents[0]);
          final minute = timeComponents[1];
          
          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }
          
          return '${hour.toString().padLeft(2, '0')}:${minute.padLeft(2, '0')}:00';
        }
      }
    } catch (e) {
      print('Error converting time to 24-hour: $e');
    }
    return time12Hour;
  }
}

