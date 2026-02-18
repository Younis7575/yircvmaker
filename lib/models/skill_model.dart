class SkillModel {
  String id;
  String name;

  SkillModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
