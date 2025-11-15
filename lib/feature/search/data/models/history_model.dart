class HistoryModel {
  int id;
  String keyword;
  DateTime date;

  HistoryModel({required this.id, required this.keyword, required this.date});

  Map<String, dynamic> toJson() {
    return {'id': id, 'keyword': keyword};
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      keyword: json['keyword'],
      date: DateTime.parse(json['date']),
    );
  }
}
