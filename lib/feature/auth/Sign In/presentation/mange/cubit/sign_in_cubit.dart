import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/data/login_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginRepo loginRepo;

  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  SignInCubit({required this.loginRepo}) : super(SignInInitial());

  Future<void> logUser() async {
    if (!formKey.currentState!.validate()) return;
  print("Sending phone number: ${phoneController.text.trim()}");
    emit(SignInLoading());

    var result = await loginRepo.loginUser(
      phoneNumber: phoneController.text.trim(),

    );

    result.fold(
      (failure) {
        emit(SignInError(error: failure.message));
      },
      (registerModel)  {
        print(registerModel.message);
        emit(SignInSuccess(message: registerModel.message));
      },
    );
  }
}
