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

      result.fold(
        (failure) {

          emit(BookingError(failure.message));
        },
        (booking) {

          emit(BookingSuccess(booking));
        },
      );
    } catch (e, stackTrace) {
      emit(BookingError('Failed to create booking: ${e.toString()}'));
    }
  }

  void reset() {
    emit(BookingInitial());
  }
}

