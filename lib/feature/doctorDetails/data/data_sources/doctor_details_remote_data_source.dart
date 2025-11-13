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
      
      // Debug: Print response
      print('API Response: $response');
      print('Response Type: ${response.runtimeType}');
      
      // Handle if response is wrapped in a data object
      Map<String, dynamic> jsonData;
      if (response is Map<String, dynamic>) {
        // Check if response has 'data' key (wrapped response)
        if (response.containsKey('data') && response['data'] != null) {
          jsonData = response['data'] as Map<String, dynamic>;
          print('Extracted data from wrapper: $jsonData');
        } else {
          // Direct response without wrapper
          jsonData = response;
        }
      } else {
        throw ServerException('Invalid response format');
      }
      
      print('Parsing JSON: $jsonData');
      return DoctorDetailsModel.fromJson(jsonData);
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      throw ServerException.fromDioError(e);
    } on ServerException catch (e) {
      print('ServerException: ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print('Stack trace: $stackTrace');
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}

