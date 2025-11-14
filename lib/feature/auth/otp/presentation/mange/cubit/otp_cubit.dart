import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/models/otp_model.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/repo/otp_repo.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpRepo otpRepo;

  OtpCubit({required this.otpRepo}) : super(OtpInitial());

  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  void disposeControllers() {
    for (var c in otpControllers) {
      c.dispose();
    }
  }

  //  Verify register OTP
  Future<void> verifyRegister({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(OtpLoading());
    final result = await otpRepo.verifyRegister(
      phoneNumber: phoneNumber,
      otpNumber: otp,
    );
    result.fold((failure) => emit(OtpError(error: failure.message)), (
      otpModel,
    ) async {
      final storage = SecureStorageService();
      await storage.write(
        key: 'accessToken',
        value: otpModel.data!.accessToken,
      );
      await storage.write(
        key: 'refreshToken',
        value: otpModel.data!.refreshToken,
      );

      emit(OtpSuccess(otpModel: otpModel, otpMessage: otpModel.message));
    });
  }

  //  Verify login OTP
  Future<void> verifyLogin({
    required String phoneNumber,
    required String otp,
  }) async {
    emit(OtpLoading());
    final result = await otpRepo.verifyLogin(
      phoneNumber: phoneNumber,
      otpNumber: otp,
    );
    result.fold((failure) => emit(OtpError(error: failure.message)), (
      otpModel,
    ) async {
      final storage = SecureStorageService();
      await storage.write(
        key: 'accessToken',
        value: otpModel.data!.accessToken,
      );
      await storage.write(
        key: 'refreshToken',
        value: otpModel.data!.refreshToken,
      );

      emit(OtpSuccess(otpModel: otpModel, otpMessage: otpModel.message));
    });
  }

  // Resend OTP
  Future<void> resendOtp({required String phoneNumber}) async {
    emit(OtpLoading());
    final result = await otpRepo.resendOtp(phoneNumber: phoneNumber);
    result.fold(
    (failure) => emit(OtpError(error: failure.message)),
    (otpModel) => emit(OtpSuccess(
      otpModel: otpModel,
      otpMessage: "OTP Resent",
      isResend: true,
    )),
  );
}
}