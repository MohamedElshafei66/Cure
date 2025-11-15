import 'package:dio/dio.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';

class ProfileRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://cure-doctor-booking.runasp.net/api/",
      headers: {"Accept": "application/json"},
    ),
  );

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _dio.get(
        "profile/Editprofile/getprofile",
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiM2UzMWNkNC1hYjFjLTQ4MTktYTVlYi1kMjJjNzc3ZWUwNTYiLCJ1bmlxdWVfbmFtZSI6IisyMDExNDM3NDExNTcyIiwiZmlyc3ROYW1lIjoibW9oYW1lZCIsImxhc3ROYW1lIjoiIiwiYWRkcmVzcyI6IiIsImltZ1VybCI6IiIsImJpcnRoRGF0ZSI6IjAwMDEtMDEtMDEiLCJnZW5kZXIiOiJNYWxlIiwibG9jYXRpb24iOiIiLCJpc05vdGlmaWNhdGlvbnNFbmFibGVkIjoiVHJ1ZSIsImV4cCI6MTc2Mjg4Nzc0MywiaXNzIjoiaHR0cHM6Ly9jdXJlLWRvY3Rvci1ib29raW5nLnJ1bmFzcC5uZXQvIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMCxodHRwczovL2xvY2FsaG9zdDo1NTAwLGh0dHBzOi8vbG9jYWxob3N0OjQyMDAgLGh0dHBzOi8vY3VyZS1kb2N0b3ItYm9va2luZy5ydW5hc3AubmV0LyJ9.RgfzAX3Ub3tGFnavi8n5lDBxu0scV9E-uEletB5TwU4",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] ?? response.data;
        return ProfileModel.fromJson(data);
      } else {
        throw const ServerException("Unexpected server response");
      }
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException("Unknown error occurred: $e");
    }
  }

  Future<bool> toggleNotification() async {
    return true;
  }
}
