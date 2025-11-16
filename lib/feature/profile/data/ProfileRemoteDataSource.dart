import 'dart:io';
import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiServices api;
  ProfileRemoteDataSource(this.api);

  Future<ProfileModel> getProfile() async {
    final response = await api.get(
      endPoint: 'profile/EditProfile/getprofile',
    );
    return ProfileModel.fromJson(response);
  }

  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String birthDate,
    File? imageFile,
    double latitude = 0,
    double longitude = 0,
  }) async {
    final formData = FormData.fromMap({
      'FullName': fullName,
      'Email': email,
      'PhoneNumber': phone,
      'Address': address,
      'BirthDate': birthDate,
      if (imageFile != null)
        'ImgFile': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    try {
      final response = await api.dio.put(
        'profile/EditProfile/updateprofile',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      print("UPDATE PROFILE SUCCESS RESPONSE: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        print("RESPONSE IS NOT A MAP! VALUE = ${response.data}");
        return {"success": false, "message": "Invalid response from server"};
      }

    } catch (e) {
      print("ERROR IN updateProfile(): $e");

      if (e is DioException) {
        print("DIO ERROR MESSAGE: ${e.message}");
        print("DIO ERROR RESPONSE DATA: ${e.response?.data}");
        print("DIO ERROR STATUS CODE: ${e.response?.statusCode}");
      }

      rethrow;
    }
  }

  Future<bool> toggleNotification() async {
    try {
      final response = await api.dio.put(
        "Profile/NotificationSettings/toggle",
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        ),
      );

      print("TOGGLE NOTIFICATION RESPONSE: ${response.data}");
      return response.statusCode == 200;

    } catch (e) {
      print("ERROR IN toggleNotification(): $e");

      if (e is DioException) {
        print("DIO ERROR RESPONSE: ${e.response?.data}");
      }
      return false;
    }
  }

  Future<bool> getNotificationStatus() async {
    try {
      final response = await api.get(
        endPoint: "Profile/NotificationSettings",
      );

      print("GET NOTIFICATION STATUS RESPONSE: $response");

      return response["status"] == true;

    } catch (e) {
      print("ERROR IN getNotificationStatus(): $e");
      return false;
    }
  }
}
