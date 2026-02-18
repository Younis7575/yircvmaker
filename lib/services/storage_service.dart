import 'package:get_storage/get_storage.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/hobby_model.dart';
import '../models/education_model.dart';
import '../models/achievement_model.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

// Add this to StorageService class
static void saveDownloadHistory(List<Map<String, dynamic>> downloads) {
  _storage.write('download_history', downloads);
}

static List<Map<String, dynamic>> getDownloadHistory() {
  final data = _storage.read('download_history');
  if (data != null && data is List) {
    return List<Map<String, dynamic>>.from(data);
  }
  return [];
}

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

  // Hobbies
  static void saveHobbies(List<HobbyModel> hobbies) {
    final hobbiesJson = hobbies.map((hobby) => hobby.toJson()).toList();
    _storage.write('hobbies', hobbiesJson);
  }

  static List<HobbyModel> getHobbies() {
    final data = _storage.read('hobbies');
    if (data != null && data is List) {
      return data.map((json) => HobbyModel.fromJson(json)).toList();
    }
    return [];
  }

  // Education
  static void saveEducations(List<EducationModel> educations) {
    final educationsJson =
        educations.map((edu) => edu.toJson()).toList();
    _storage.write('educations', educationsJson);
  }

  static List<EducationModel> getEducations() {
    final data = _storage.read('educations');
    if (data != null && data is List) {
      return data.map((json) => EducationModel.fromJson(json)).toList();
    }
    return [];
  }

  // Achievements
  static void saveAchievements(List<AchievementModel> achievements) {
    final achievementsJson =
        achievements.map((ach) => ach.toJson()).toList();
    _storage.write('achievements', achievementsJson);
  }

  static List<AchievementModel> getAchievements() {
    final data = _storage.read('achievements');
    if (data != null && data is List) {
      return data.map((json) => AchievementModel.fromJson(json)).toList();
    }
    return [];
  }

  // Clear all data
  static void clearAll() {
    _storage.erase();
  }
}
