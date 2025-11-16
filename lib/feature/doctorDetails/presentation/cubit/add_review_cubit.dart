import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/use_cases/add_review_use_case.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  final AddReviewUseCase addReviewUseCase;

  AddReviewCubit({required this.addReviewUseCase}) : super(AddReviewInitial());

  double _rating = 0.0;
  String _comment = '';

  double get rating => _rating;
  String get comment => _comment;

  void setRating(double rating) {
    _rating = rating;
    emit(AddReviewRatingChanged(_rating));
  }

  void setComment(String comment) {
    _comment = comment;
  }

  Future<void> addReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    try {
      emit(AddReviewLoading());
      print('AddReviewCubit: Adding review for doctorId: $doctorId');
      
      final result = await addReviewUseCase(
        AddReviewParams(
          doctorId: doctorId,
          rating: rating,
          comment: comment,
        ),
      );

      result.fold(
        (failure) {
          print('AddReviewCubit: Error - ${failure.message}');
          emit(AddReviewError(failure.message));
        },
        (success) {
          print('AddReviewCubit: Success - Review added');
          emit(AddReviewSuccess());
        },
      );
    } catch (e, stackTrace) {
      print('AddReviewCubit: Exception - $e');
      print('Stack trace: $stackTrace');
      emit(AddReviewError('Failed to add review: ${e.toString()}'));
    }
  }

  void reset() {
    _rating = 0.0;
    _comment = '';
    emit(AddReviewInitial());
  }
}

