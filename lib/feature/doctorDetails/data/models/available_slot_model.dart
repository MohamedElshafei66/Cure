class AvailableSlotModel {
  final int id;
  final int doctorId;
  final DateTime dateTime;
  final String startTime;
  final String endTime;
  final bool isBooked;

  AvailableSlotModel({
    required this.id,
    required this.doctorId,
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) {
    return AvailableSlotModel(
      id: json['id'] ?? 0,
      doctorId: json['doctorId'] ?? 0,
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'])
          : DateTime.now(),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      isBooked: json['isBooked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'dateTime': dateTime.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'isBooked': isBooked,
    };
  }
}

