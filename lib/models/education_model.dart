class EducationModel {
  String id;
  String degree;
  String institution;
  String duration;
  String? description;

  EducationModel({
    required this.id,
    required this.degree,
    required this.institution,
    required this.duration,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'institution': institution,
      'duration': duration,
      'description': description,
    };
  }

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'] ?? '',
      degree: json['degree'] ?? '',
      institution: json['institution'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'],
    );
  }
}
