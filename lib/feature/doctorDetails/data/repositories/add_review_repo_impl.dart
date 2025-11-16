import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/add_review_repo.dart';
import '../data_sources/add_review_remote_data_source.dart';

class AddReviewRepoImpl implements AddReviewRepo {
  final AddReviewRemoteDataSource remoteDataSource;

  AddReviewRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> addReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    try {
      final result = await remoteDataSource.addReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e, stackTrace) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}

