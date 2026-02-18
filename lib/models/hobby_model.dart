class HobbyModel {
  String id;
  String name;

  HobbyModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory HobbyModel.fromJson(Map<String, dynamic> json) {
    return HobbyModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
