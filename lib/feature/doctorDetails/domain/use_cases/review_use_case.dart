import 'package:dartz/dartz.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/core/use_cases/use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/entites/review_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/review_repo.dart';

class ReviewUseCase extends UseCase<List<ReviewEntity>,String>{
  final ReviewRepo reviewRepo;
  ReviewUseCase(this.reviewRepo);

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(String doctorId)async{
    return await reviewRepo.fetchReviewsAboutDoctor(doctorId);
  }



}






/*class ReviewUseCase{
  final ReviewRepo reviewRepo;
  ReviewUseCase(this.reviewRepo);
  Future <Either<Failure,List<ReviewEntity>>> fetchReviewsAboutDoctor(){
    return reviewRepo.fetchReviewsAboutDoctor();
}
}*/