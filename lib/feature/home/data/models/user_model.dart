class UserModel {
  final String fullName;
  final String? imgUrl;
  final String? address;

  UserModel({
    required this.fullName,
    required this.imgUrl,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      imgUrl: json['imgUrl'],
      address: json['address'],
    );
  }
}
