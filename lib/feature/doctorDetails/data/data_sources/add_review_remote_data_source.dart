import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_services.dart';
import 'package:dio/dio.dart';

abstract class AddReviewRemoteDataSource {
  Future<bool> addReview({
    required int doctorId,
    required int rating,
    required String comment,
  });
}

class AddReviewRemoteDataSourceImpl implements AddReviewRemoteDataSource {
  final ApiServices apiServices;

  AddReviewRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<bool> addReview({
    required int doctorId,
    required int rating,
    required String comment,
  }) async {
    try {
      final endpoint = 'Customer/Reviews/AddReview';
      
      final body = {
        'doctorId': doctorId,
        'rating': rating,
        'comment': comment,
      };

      
      final response = await apiServices.post(endPoint: endpoint, body: body);


      // Check if response indicates success
      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          return true;
        } else {
          final message = response['message'] ?? 'Failed to add review';
          throw ServerException(message);
        }
      }
      
      return true;
    } on DioException catch (e) {

      throw ServerException.fromDioError(e);
    } on ServerException catch (e) {
      rethrow;
    } catch (e, stackTrace) {

      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}

