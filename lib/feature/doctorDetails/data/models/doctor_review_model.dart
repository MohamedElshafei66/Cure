class DoctorReviewModel {
  final int? patientId;
  final int? doctorId;
  final String patientName;
  final String doctorName;
  final double rating;
  final String comment;
  final DateTime? createdAt;

  DoctorReviewModel({
    this.patientId,
    this.doctorId,
    String? patientName,
    String? doctorName,
    double? rating,
    String? comment,
    this.createdAt,
  })  : patientName = (patientName == null || patientName.isEmpty)
            ? 'User'
            : patientName,
        doctorName = doctorName ?? '',
        rating = rating ?? 0,
        comment = (comment == null || comment.isEmpty)
            ? 'No comment provided.'
            : comment;

  factory DoctorReviewModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    final createdAt = json['createdAt'];
    if (createdAt is String && createdAt.isNotEmpty) {
      parsedDate = DateTime.tryParse(createdAt);
    }

    double? parsedRating;
    final ratingValue = json['rating'];
    if (ratingValue is num) {
      parsedRating = ratingValue.toDouble();
    } else if (ratingValue is String) {
      parsedRating = double.tryParse(ratingValue);
    }

    return DoctorReviewModel(
      patientId: _parseInt(json['patientId']),
      doctorId: _parseInt(json['doctorId']),
      patientName: json['patientName']?.toString(),
      doctorName: json['doctorName']?.toString(),
      rating: parsedRating,
      comment: json['comment']?.toString(),
      createdAt: parsedDate,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is num) return value.toInt();
    return null;
  }
}


