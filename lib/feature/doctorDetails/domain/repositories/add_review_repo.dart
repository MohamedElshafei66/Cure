import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class AddReviewRepo {
  Future<Either<Failure, bool>> addReview({
    required int doctorId,
    required int rating,
    required String comment,
  });
}

