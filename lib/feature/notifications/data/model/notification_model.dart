class NotificationModel {
  final int id;
  final String content;
  final String? applicationUserId;
  final int types;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.content,
    this.applicationUserId,
    required this.types,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      content: json['content'],
      applicationUserId: json['applicationUserId'],
      types: json['types'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
