class SpecialistModel {
  final int id;
  final String title;
  final String emoji;

  SpecialistModel({required this.id, required this.title, required this.emoji});

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      title: json['title'],
      emoji: json['emoji'],
    );
  }
}
