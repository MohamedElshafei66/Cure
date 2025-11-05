class NotificationModel {
  String? imageUrl;
  String title;
  String description;
  String date;
  NotificationModel({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
  });
}