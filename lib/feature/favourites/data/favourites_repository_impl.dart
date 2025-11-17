import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final ApiServices apiServices;

  FavouritesRepositoryImpl(this.apiServices);

  @override
  Future<List<DoctorModel>> getFavourites() async {
    try {
      final response = await apiServices.get(
        endPoint: ApiEndpoints.getFavouriteDoctors,
      );

      if (response == null || response['data'] == null) {
        return [];
      }

      final favouritesJson = response['data'] as List<dynamic>?;

      // Handle null or empty list
      if (favouritesJson == null || favouritesJson.isEmpty) {
        return [];
      }

      return favouritesJson.map((json) => DoctorModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // Handle 404 as empty list (no favourites found)
      if (e.response?.statusCode == 404) {
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message']?.toString().toLowerCase() ?? '';
          if (message.contains('no favourites') || 
              message.contains('not found') ||
              message.contains('matching the criteria')) {
            return [];
          }
        }
        // If 404 but message doesn't match, still return empty list
        return [];
      }
      
      final errorString = e.toString();
      if (errorString.contains('No favourites found') ||
          errorString.contains('No favourites found.')) {
        return [];
      }

      if (errorString.contains('success: false') &&
          errorString.contains('data: null')) {
        return [];
      }

      throw Exception('Failed to fetch favourites: $e');
    } catch (e) {
      final errorString = e.toString();

      if (errorString.contains('No favourites found') ||
          errorString.contains('No favourites found.')) {
        return [];
      }

      if (errorString.contains('success: false') &&
          errorString.contains('data: null')) {
        return [];
      }

      throw Exception('Failed to fetch favourites: $e');
    }
  }

  @override
  Future<void> toggleFavourite(DoctorModel doctor) async {
    try {
      final body = {'doctorId': doctor.id};
      await apiServices.post(
        endPoint: ApiEndpoints.favouriteAndUnFav,
        body: body,
      );
    } catch (e) {
      throw Exception('Failed to add doctor to favourites: $e');
    }
  }
}
