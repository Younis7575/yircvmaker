class AchievementModel {
  String id;
  String title;
  String description;
  String? date;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'],
    );
  }
}
