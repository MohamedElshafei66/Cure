part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {
  final String message;
  SignUpSuccess({required this.message});
}
class SignUpError extends SignUpState {
  final String error;

  SignUpError({required this.error});
}
