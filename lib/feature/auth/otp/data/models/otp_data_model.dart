class OtpDataModel {
  final String accessToken;
  final String refreshToken;

  OtpDataModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory OtpDataModel.fromJson(Map<String, dynamic> json) => OtpDataModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
