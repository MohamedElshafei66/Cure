part of 'otp_cubit.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpSuccess extends OtpState {
  final OtpModel otpModel;
  final String? otpMessage;
  final bool isResend;
  OtpSuccess({required this.otpModel, this.otpMessage, this.isResend = false});
}

class OtpLoading extends OtpState {}

class OtpError extends OtpState {
  final String error;

  OtpError({required this.error});
}
