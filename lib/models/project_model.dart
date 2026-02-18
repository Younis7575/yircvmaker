class ProjectModel {
  String id;
  String name;
  String description;
  String technologies;
  String? projectLink;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.technologies,
    this.projectLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'technologies': technologies,
      'projectLink': projectLink,
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      technologies: json['technologies'] ?? '',
      projectLink: json['projectLink'],
    );
  }
}
