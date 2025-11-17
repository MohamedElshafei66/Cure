

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(_handleError(e)));
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String birthDate,
    File? imageFile,
  }) async {
    emit(ProfileUpdateLoading());

    try {
      final response = await repository.updateProfile(
        fullName: fullName,
        email: email,
        phone: phone,
        address: address,
        birthDate: birthDate,
        imageFile: imageFile,
      );

      if (response["success"] == true) {
        emit(ProfileUpdateSuccess(response["message"] ?? "Profile updated successfully"));
      } else {
        emit(ProfileUpdateError(response["message"] ?? "Failed to update"));
      }
    } catch (e) {
      print(" ERROR IN PROFILE CUBIT: $e");
      emit(ProfileUpdateError(_handleError(e)));
    }
  }


  String _handleError(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;


      if (data is Map && data.containsKey('errors')) {
        final errors = data['errors'] as Map<String, dynamic>;
        final firstKey = errors.keys.first;
        final firstMessageList = errors[firstKey];

        if (firstMessageList is List && firstMessageList.isNotEmpty) {
          return firstMessageList.first;
        }
      }


      if (data is Map && data.containsKey('title')) {
        return data['title'];
      }

      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }


      return error.message ?? "Network error occurred";
    }

    if (error is SocketException) {
      return "No internet connection";
    }

    return error.toString();
  }

}