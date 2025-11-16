part of 'booking_search_cubit.dart';

abstract class BookingSearchState extends Equatable {
  const BookingSearchState();

  @override
  List<Object> get props => [];
}

class BookingSearchInitial extends BookingSearchState {}

class BookingSearchLoading extends BookingSearchState {}

class BookingSearchSuccess extends BookingSearchState {
  final List<BookingEntity> bookings;

  const BookingSearchSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}

class BookingSearchError extends BookingSearchState {
  final String message;

  const BookingSearchError(this.message);

  @override
  List<Object> get props => [message];
}

