import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/models/doctor_detail_model.dart';

abstract class DoctorDetailsRemoteDataSource {
  Future<DoctorDetailsModel> fetchDoctorDetails(int doctorId);
}

class DoctorDetailsRemoteDataSourceImpl implements DoctorDetailsRemoteDataSource {
  final ApiServices apiServices;

  DoctorDetailsRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<DoctorDetailsModel> fetchDoctorDetails(int doctorId) async {
    try {
      final endpoint = 'Customer/Doctors/DoctorDetails/$doctorId';
      final response = await apiServices.get(endPoint: endpoint);

      
      // Handle if response is wrapped in a data object
      Map<String, dynamic> jsonData;
      if (response is Map<String, dynamic>) {
        // Check if response has 'data' key (wrapped response)
        if (response.containsKey('data') && response['data'] != null) {
          jsonData = response['data'] as Map<String, dynamic>;
        } else {

          jsonData = response;
        }
      } else {
        throw ServerException('Invalid response format');
      }

      return DoctorDetailsModel.fromJson(jsonData);
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } on ServerException catch (e) {
      rethrow;
    } catch (e, stackTrace) {
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}

