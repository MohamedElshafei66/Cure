class DoctorModel {
  final int id;
  final String fullName;
  final String about;
  final String imgUrl;
  final int specialityId;
  final String specialistTitle;
  final String address;
  final double rating;
  final bool isFavourite;
  final int price;
  final String? distance;
  final String? startDate;
  final String? endDate;

  DoctorModel({
    required this.id,
    required this.fullName,
    required this.about,
    required this.imgUrl,
    required this.specialityId,
    required this.specialistTitle,
    required this.address,
    required this.rating,
    required this.isFavourite,
    required this.price,
    this.distance,
    this.startDate,
    this.endDate,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    const String baseUrl = 'https://cure-doctor-booking.runasp.net/';
    final rawImage = json['imgUrl'];

    final fullImageUrl = (rawImage != null && rawImage.toString().isNotEmpty)
        ? (rawImage.toString().startsWith('http')
              ? rawImage.toString()
              : '$baseUrl$rawImage')
        : '${baseUrl}images/default.jpg';

    return DoctorModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      about: json['about'] ?? '',
      imgUrl: fullImageUrl,
      specialityId: json['specialityId'] ?? 0,
      specialistTitle: json['specialistTitle'] ?? '',
      address: json['address'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isFavourite: json['isFavourite'] ?? false,
      price: json['price'] ?? 0,
      distance: json['distance']?.toString(),
      startDate: json['startDate']?.toString(),
      endDate: json['endDate']?.toString(),
    );
  }
}
