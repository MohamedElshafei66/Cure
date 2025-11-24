import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/models/user_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/domain/repositories/user_repository.dart'
    as user_repo;

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserCubit extends Cubit<UserState> {
  final user_repo.UserRepo userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  Future<void> loadUser() async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void refreshUser() {
    loadUser();
  }
}
