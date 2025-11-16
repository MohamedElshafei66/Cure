class ProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthDate;
  final String imgUrl;

  const ProfileModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.birthDate,
    required this.imgUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // API may return {"data": {...}} or directly the fields
    final data = json['data'] ?? json;

    final rawBirth = data['birthDate'] ?? '';
    final birthDate = (rawBirth == null || rawBirth == "0001-01-01T00:00:00") ? '' : rawBirth.toString();

    final rawImg = data['imgUrl'] ?? '';
    final imgUrl = rawImg == null ? '' : rawImg.toString();

    return ProfileModel(
      fullName: (data['fullName'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      phoneNumber: (data['phoneNumber'] ?? '').toString(),
      address: (data['address'] ?? '').toString(),
      birthDate: birthDate,
      imgUrl: imgUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "birthDate": birthDate,
        "imgUrl": imgUrl,
      };
}
