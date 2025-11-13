import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entites/booking_entity.dart';
import '../../domain/use_cases/create_booking_use_case.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final CreateBookingUseCase createBookingUseCase;

  BookingCubit({required this.createBookingUseCase}) : super(BookingInitial());

  Future<void> createBooking({
    required int doctorId,
    required int slotId,
    required double amount,
    required int payment,
    required int status,
    required DateTime appointmentAt,
  }) async {
    try {
      emit(BookingLoading());
      print('========================================');
      print('BOOKING CUBIT: Starting createBooking');
      print('========================================');
      print('Parameters received:');
      print('  - doctorId: $doctorId (${doctorId.runtimeType})');
      print('  - slotId: $slotId (${slotId.runtimeType})');
      print('  - amount: $amount (${amount.runtimeType})');
      print('  - payment: $payment (${payment.runtimeType})');
      print('  - status: $status (${status.runtimeType})');
      print('  - appointmentAt: $appointmentAt (${appointmentAt.runtimeType})');
      print('========================================');
      print('Calling createBookingUseCase...');
      print('========================================');
      
      final result = await createBookingUseCase(
        CreateBookingParams(
          doctorId: doctorId,
          slotId: slotId,
          amount: amount,
          payment: payment,
          status: status,
          appointmentAt: appointmentAt,
        ),
      );
      
      print('========================================');
      print('USE CASE RETURNED RESULT');
      print('========================================');

      result.fold(
        (failure) {
          print('========================================');
          print('BOOKING CUBIT: ERROR');
          print('========================================');
          print('Error Message: ${failure.message}');
          print('========================================');
          emit(BookingError(failure.message));
        },
        (booking) {
          print('========================================');
          print('BOOKING CUBIT: SUCCESS');
          print('========================================');
          print('Booking received in cubit:');
          print('  - ID: ${booking.id}');
          print('  - Doctor: ${booking.doctorName}');
          print('  - Payment: ${booking.payment}');
          print('  - Status: ${booking.status}');
          print('  - Payment URL: ${booking.paymentUrl ?? "N/A"}');
          print('  - Appointment: ${booking.appointmentAt}');
          print('========================================');
          print('Emitting BookingSuccess state...');
          print('========================================');
          emit(BookingSuccess(booking));
        },
      );
    } catch (e, stackTrace) {
      print('BookingCubit: Exception - $e');
      print('Stack trace: $stackTrace');
      emit(BookingError('Failed to create booking: ${e.toString()}'));
    }
  }

  void reset() {
    emit(BookingInitial());
  }
}

