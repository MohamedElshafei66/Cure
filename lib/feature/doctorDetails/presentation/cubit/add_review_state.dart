part of 'add_review_cubit.dart';

abstract class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewRatingChanged extends AddReviewState {
  final double rating;

  const AddReviewRatingChanged(this.rating);

  @override
  List<Object> get props => [rating];
}

class AddReviewSuccess extends AddReviewState {}

class AddReviewError extends AddReviewState {
  final String message;

  const AddReviewError(this.message);

  @override
  List<Object> get props => [message];
}

