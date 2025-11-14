import 'package:round_7_mobile_cure_team3/feature/auth/otp/data/models/otp_data_model.dart';

class OtpModel {
  final bool success;
  final String message;
  final OtpDataModel? data;
  OtpModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? OtpDataModel.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
