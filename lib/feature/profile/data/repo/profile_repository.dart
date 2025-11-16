import 'dart:io';
import '../ProfileRemoteDataSource.dart';
import '../model/profile_model.dart';

class ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepository(this.remoteDataSource);

  Future<ProfileModel> getProfile() => remoteDataSource.getProfile();

  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String birthDate,
    File? imageFile,
    double latitude = 0,
    double longitude = 0,
  }) {
    return remoteDataSource.updateProfile(
      fullName: fullName,
      email: email,
      phone: phone,
      address: address,
      birthDate: birthDate,
      imageFile: imageFile,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<bool> getNotificationStatus() =>
      remoteDataSource.getNotificationStatus();

  Future<bool> toggleNotification() =>
      remoteDataSource.toggleNotification();
}