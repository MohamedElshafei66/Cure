import 'dart:io';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_endpoints.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/ProfileRemoteDataSource.dart';

class ProfileRepository {
  final ApiServices apiServices;
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepository({SecureStorageService? secureStorage})
      : apiServices = ApiServices(secureStorage: secureStorage),
        remoteDataSource = ProfileRemoteDataSource(
          ApiServices(secureStorage: secureStorage),
        );

  Future<ProfileModel> getProfile() async {
    try {
      final response = await apiServices.get(
        endPoint: "profile/Editprofile/getprofile",
      );

      if (response != null) {
        final data = response['data'] ?? response;
        return ProfileModel.fromJson(data);
      } else {
        throw const ServerException("Unexpected server response");
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException("Unknown error occurred: $e");
    }
  }

  Future<ProfileModel> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String birthDate,
    File? imageFile,
    double latitude = 0,
    double longitude = 0,
  }) async {
    try {
      final response = await remoteDataSource.updateProfile(
        fullName: fullName,
        email: email,
        phone: phone,
        address: address,
        birthDate: birthDate,
        imageFile: imageFile,
        latitude: latitude,
        longitude: longitude,
      );

      if (response['success'] == true || response['message'] != null) {
        // Fetch updated profile
        return await getProfile();
      } else {
        throw ServerException(response['message'] ?? "Failed to update profile");
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException("Failed to update profile: $e");
    }
  }

  Future<bool> toggleNotification() async {
    try {
      return await remoteDataSource.toggleNotification();
    } catch (e) {
      throw ServerException("Failed to toggle notification: $e");
    }
  }

  Future<bool> getNotificationStatus() async {
    try {
      return await remoteDataSource.getNotificationStatus();
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await apiServices.post(
        endPoint: ApiEndpoints.logout,
        body: {},
      );
    } catch (e) {
      // Even if logout fails on server, clear local tokens
      print("Logout error: $e");
    }
  }
}
