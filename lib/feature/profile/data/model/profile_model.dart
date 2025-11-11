class ProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthDate;
  final String imgUrl;

  ProfileModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.birthDate,
    required this.imgUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      birthDate: json['birthDate'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
    );
  }
}
