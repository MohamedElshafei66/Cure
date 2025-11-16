import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/entities/reschedule_entity.dart';
import '../../domain/use_cases/get_booking_use_case.dart';
import '../../domain/use_cases/cancel_booking_use_case.dart';
import '../../domain/use_cases/reschedule_booking_use_case.dart';

part 'booking_search_state.dart';

class BookingSearchCubit extends Cubit<BookingSearchState> {
  final GetBookingUseCase getBookingUseCase;
  final CancelBookingUseCase cancelBookingUseCase;
  final RescheduleBookingUseCase rescheduleBookingUseCase;
  String? currentFromDate;

  BookingSearchCubit({
    required this.getBookingUseCase,
    required this.cancelBookingUseCase,
    required this.rescheduleBookingUseCase,
  }) : super(BookingSearchInitial());

  Future<void> fetchBookings({String? fromDate}) async {
    currentFromDate = fromDate;
    emit(BookingSearchLoading());
    
    final result = await getBookingUseCase(GetBookingParams(fromDate: fromDate));
    
    result.fold(
      (failure) {
        emit(BookingSearchError(failure.message));
      },
      (bookings) {
        emit(BookingSearchSuccess(bookings));
      },
    );
  }

  Future<void> cancelBooking(String bookingId) async {
    emit(BookingSearchLoading());
    
    final result = await cancelBookingUseCase(bookingId);
    
    result.fold(
      (failure) {
        emit(BookingSearchError(failure.message));
      },
      (_) {
        // After successful cancellation, refresh the bookings
        fetchBookings(fromDate: currentFromDate);
      },
    );
  }

  Future<void> rescheduleBooking(RescheduleEntity rescheduleEntity) async {
    emit(BookingSearchLoading());
    
    final result = await rescheduleBookingUseCase(rescheduleEntity);
    
    result.fold(
      (failure) {
        emit(BookingSearchError(failure.message));
      },
      (_) {
        // After successful rescheduling, refresh the bookings
        fetchBookings(fromDate: currentFromDate);
      },
    );
  }
}

