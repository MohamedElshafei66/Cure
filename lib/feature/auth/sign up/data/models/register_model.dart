class RegisterModel {
  final bool success;
  final String message;
  final dynamic data;

  RegisterModel({
    required this.success,
    required this.message,
    required this.data,
  });
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }
}
