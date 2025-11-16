import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/review_entity.dart';

abstract class ReviewRepo{
  Future<Either<Failure,List<ReviewEntity>>> fetchReviewsAboutDoctor(String doctorId);
}