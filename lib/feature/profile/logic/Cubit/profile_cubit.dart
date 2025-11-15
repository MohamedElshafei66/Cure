import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  final SecureStorageService? secureStorage;

  ProfileCubit(this.repository, {this.secureStorage}) : super(ProfileInitial());

  Future<void> fetchProfile(String token) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfile();
      final notificationStatus = await repository.getNotificationStatus();
      emit(ProfileLoaded(profile, notificationEnabled: notificationStatus));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError("Something went wrong: $e"));
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String birthDate,
    File? imageFile,
    double latitude = 0,
    double longitude = 0,
  }) async {
    emit(ProfileUpdating());
    try {
      final updatedProfile = await repository.updateProfile(
        fullName: fullName,
        email: email,
        phone: phone,
        address: address,
        birthDate: birthDate,
        imageFile: imageFile,
        latitude: latitude,
        longitude: longitude,
      );
      emit(ProfileUpdated(updatedProfile));
      // Refresh profile with notification status
      final notificationStatus = await repository.getNotificationStatus();
      emit(ProfileLoaded(updatedProfile, notificationEnabled: notificationStatus));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError("Failed to update profile: $e"));
    }
  }

  Future<void> toggleNotification() async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(NotificationToggling());
      try {
        final success = await repository.toggleNotification();
        if (success) {
          final newStatus = !(currentState.notificationEnabled ?? false);
          emit(NotificationToggled(newStatus));
          // Update profile state with new notification status
          emit(ProfileLoaded(currentState.profile, notificationEnabled: newStatus));
        } else {
          emit(ProfileError("Failed to toggle notification"));
        }
      } on ServerException catch (e) {
        emit(ProfileError(e.message));
        // Restore previous state
        emit(ProfileLoaded(currentState.profile, notificationEnabled: currentState.notificationEnabled));
      } catch (e) {
        emit(ProfileError("Failed to toggle notification: $e"));
        // Restore previous state
        emit(ProfileLoaded(currentState.profile, notificationEnabled: currentState.notificationEnabled));
      }
    }
  }

  Future<void> logout() async {
    emit(LoggingOut());
    try {
      await repository.logout();
      
      // Clear tokens from secure storage
      if (secureStorage != null) {
        await secureStorage!.delete(key: 'accessToken');
        await secureStorage!.delete(key: 'refreshToken');
      }
      
      emit(LoggedOut());
    } catch (e) {
      // Even if logout fails, clear local tokens
      if (secureStorage != null) {
        await secureStorage!.delete(key: 'accessToken');
        await secureStorage!.delete(key: 'refreshToken');
      }
      emit(LoggedOut());
    }
  }
}



