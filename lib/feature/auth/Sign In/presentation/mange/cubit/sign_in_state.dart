part of 'sign_in_cubit.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final String message;

  SignInSuccess({required this.message});
}

class SignInLoading extends SignInState {}

class SignInError extends SignInState {
  final String error;

  SignInError({required this.error});
}
