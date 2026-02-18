class ExperienceModel {
  String id;
  String jobTitle;
  String companyName;
  String duration;
  String description;

  ExperienceModel({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.duration,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'duration': duration,
      'description': description,
    };
  }

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      companyName: json['companyName'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
