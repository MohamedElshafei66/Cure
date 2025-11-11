import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/errors/exceptions.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit(this.repository) : super(ProfileInitial());

  Future<void> fetchProfile(String token) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getProfile();
      emit(ProfileLoaded(profile));
    } on ServerException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError("Something went wrong: $e"));
    }
  }
}



