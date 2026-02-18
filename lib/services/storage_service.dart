import 'package:get_storage/get_storage.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  // Profile
  static void saveProfile(ProfileModel profile) {
    _storage.write('profile', profile.toJson());
  }

  static ProfileModel? getProfile() {
    final data = _storage.read('profile');
    if (data != null) {
      return ProfileModel.fromJson(data);
    }
    return null;
  }

  // Skills
  static void saveSkills(List<SkillModel> skills) {
    final skillsJson = skills.map((skill) => skill.toJson()).toList();
    _storage.write('skills', skillsJson);
  }

  static List<SkillModel> getSkills() {
    final data = _storage.read('skills');
    if (data != null && data is List) {
      return data.map((json) => SkillModel.fromJson(json)).toList();
    }
    return [];
  }

  // Projects
  static void saveProjects(List<ProjectModel> projects) {
    final projectsJson = projects.map((project) => project.toJson()).toList();
    _storage.write('projects', projectsJson);
  }

  static List<ProjectModel> getProjects() {
    final data = _storage.read('projects');
    if (data != null && data is List) {
      return data.map((json) => ProjectModel.fromJson(json)).toList();
    }
    return [];
  }

  // Experience
  static void saveExperiences(List<ExperienceModel> experiences) {
    final experiencesJson =
        experiences.map((exp) => exp.toJson()).toList();
    _storage.write('experiences', experiencesJson);
  }

  static List<ExperienceModel> getExperiences() {
    final data = _storage.read('experiences');
    if (data != null && data is List) {
      return data.map((json) => ExperienceModel.fromJson(json)).toList();
    }
    return [];
  }

  // Clear all data
  static void clearAll() {
    _storage.erase();
  }
}
