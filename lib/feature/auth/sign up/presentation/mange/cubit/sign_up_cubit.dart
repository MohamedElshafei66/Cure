import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/errors/failures.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/data/repo/register_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final RegisterRepo registerRepo;
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  SignUpCubit({required this.registerRepo}) : super(SignUpInitial());

  Future<void> registUser() async {
    if (!formKey.currentState!.validate()) return;

    emit(SignUpLoading());

    var result = await registerRepo.registerUser(
      fullName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
    );

    result.fold(
      (failure) {
        emit(SignUpError(error: failure.message));
      },
      (registerModel)  {
        print(registerModel.message);
        emit(SignUpSuccess(message: registerModel.message));
      },
    );
  }
}
