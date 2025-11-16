import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/add_review_repo.dart';

class AddReviewUseCase implements UseCase<bool, AddReviewParams> {
  final AddReviewRepo addReviewRepo;

  AddReviewUseCase(this.addReviewRepo);

  @override
  Future<Either<Failure, bool>> call(AddReviewParams params) async {
    return await addReviewRepo.addReview(
      doctorId: params.doctorId,
      rating: params.rating,
      comment: params.comment,
    );
  }
}

class AddReviewParams {
  final int doctorId;
  final int rating;
  final String comment;

  AddReviewParams({
    required this.doctorId,
    required this.rating,
    required this.comment,
  });
}

