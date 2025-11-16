import 'dart:io';

import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiServices api;

  ProfileRemoteDataSource(this.api);

  Future<ProfileModel> getProfile() async {
<<<<<<< HEAD
    final response = await api.get(endPoint: 'profile/EditProfile/getprofile');
=======
    final response = await api.get(
      endPoint: 'profile/EditProfile/getprofile',
     // withToken: true,
    );
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
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
<<<<<<< HEAD
=======
   // final token = await api.getToken();

>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
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
      // Get token from secure storage if available
      final token = await api.getToken();
      final headers = <String, String>{'Accept': 'application/json'};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await api.dio.put(
        '${api.baseUrl}profile/EditProfile/updateprofile',
        data: formData,
<<<<<<< HEAD
        options: Options(headers: headers),
=======
        options: Options(
          headers: {
           // 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      );

      print(" UPDATE PROFILE SUCCESS RESPONSE: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        print(" RESPONSE IS NOT A MAP! VALUE = ${response.data}");
        return {"success": false, "message": "Invalid response from server"};
      }
    } catch (e) {
      print(" ERROR IN updateProfile(): $e");

      if (e is DioException) {
        print(" DIO ERROR MESSAGE: ${e.message}");
        print(" DIO ERROR RESPONSE DATA: ${e.response?.data}");
        print(" DIO ERROR STATUS CODE: ${e.response?.statusCode}");
      }

      rethrow;
    }
  }

  Future<bool> toggleNotification() async {
<<<<<<< HEAD
=======
   // final token = await api.getToken();

>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
    try {
      final token = await api.getToken();
      final headers = <String, String>{'Accept': 'application/json'};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await api.dio.put(
        "${api.baseUrl}Profile/NotificationSettings/toggle",
<<<<<<< HEAD
        options: Options(headers: headers),
=======
        options: Options(
          headers: {
           // "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      );

      print(" TOGGLE NOTIFICATION RESPONSE: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      print(" ERROR IN toggleNotification(): $e");

      if (e is DioException) {
        print(" DIO ERROR RESPONSE: ${e.response?.data}");
      }
      return false;
    }
  }

  Future<bool> getNotificationStatus() async {
    try {
<<<<<<< HEAD
      final response = await api.get(endPoint: "Profile/NotificationSettings");
=======
      final response = await api.get(
        endPoint: "Profile/NotificationSettings",
       // withToken: true,
      );
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab

      print(" GET NOTIFICATION STATUS RESPONSE: $response");

      return response["status"] == true;
    } catch (e) {
      print(" ERROR IN getNotificationStatus(): $e");
      return false;
    }
  }
}
