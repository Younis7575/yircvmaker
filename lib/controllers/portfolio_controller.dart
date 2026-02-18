// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../models/profile_model.dart';
// import '../models/skill_model.dart';
// import '../models/project_model.dart';
// import '../models/experience_model.dart';
// import '../models/hobby_model.dart';
// import '../models/education_model.dart';
// import '../models/achievement_model.dart';
// import '../services/storage_service.dart';
// import '../services/pdf_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/material.dart';

// class PortfolioController extends GetxController {

// // Add these imports at the top of your controller file


// // Add these observable variables
// final _downloadProgress = <String, double>{}.obs;
// final _recentDownloads = <Map<String, dynamic>>[].obs;

// Map<String, double> get downloadProgress => _downloadProgress;
// List<Map<String, dynamic>> get recentDownloads => _recentDownloads;

// // Add this method to track downloads
// Future<void> generateAndSavePdfWithTracking({int? templateNumber}) async {
//   final message = getProfileCompletenessMessage();
//   if (message != null) {
//     Get.snackbar('Incomplete Profile', message,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white);
//     return;
//   }

//   _isLoading.value = true;
//   final template = templateNumber ?? _selectedTemplate.value;
//   final downloadId = DateTime.now().millisecondsSinceEpoch.toString();
  
//   try {
//     // Add to recent downloads
//     _downloadProgress[downloadId] = 0.0;
//     _recentDownloads.insert(0, {
//       'id': downloadId,
//       'templateNumber': template,
//       'templateName': _getTemplateName(template),
//       'timestamp': DateTime.now(),
//       'status': 'downloading',
//       'filePath': null,
//     });

//     // Simulate progress (you can replace this with actual progress from PDF generation)
//     for (int i = 1; i <= 10; i++) {
//       await Future.delayed(const Duration(milliseconds: 100));
//       _downloadProgress[downloadId] = i / 10;
//     }

//     final pdfBytes = await PdfService.generatePortfolioPdf(
//       profile: _profile.value!,
//       skills: _skills,
//       projects: _projects,
//       experiences: _experiences,
//       hobbies: _hobbies,
//       educations: _educations,
//       achievements: _achievements,
//       profileImagePath: _profile.value!.profileImagePath,
//       templateNumber: template,
//     );

//     final fileName = 'portfolio_template${template}_${DateTime.now().millisecondsSinceEpoch}';
//     final filePath = await PdfService.savePdf(pdfBytes, fileName);
    
//     // Update download status
//     _downloadProgress[downloadId] = 1.0;
//     final index = _recentDownloads.indexWhere((d) => d['id'] == downloadId);
//     if (index != -1) {
//       _recentDownloads[index] = {
//         'id': downloadId,
//         'templateNumber': template,
//         'templateName': _getTemplateName(template),
//         'timestamp': DateTime.now(),
//         'status': 'completed',
//         'filePath': filePath,
//       };
//     }

//     Get.snackbar('Success', 'PDF saved successfully',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white);
//   } catch (e) {
//     // Update download status to failed
//     final index = _recentDownloads.indexWhere((d) => d['id'] == downloadId);
//     if (index != -1) {
//       _recentDownloads[index] = {
//         ..._recentDownloads[index],
//         'status': 'failed',
//       };
//     }
    
//     Get.snackbar('Error', 'Failed to generate PDF: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white);
//   } finally {
//     _isLoading.value = false;
//   }
// }

// String _getTemplateName(int templateNumber) {
//   switch (templateNumber) {
//     case 1:
//       return 'Classic Professional';
//     case 2:
//       return 'Modern Sidebar';
//     case 3:
//       return 'Minimalist';
//     case 4:
//       return 'Two Column';
//     case 5:
//       return 'Creative Colors';
//     default:
//       return 'Template $templateNumber';
//   }
// }

// // Add method to open downloaded file
// Future<void> openDownloadedFile(String filePath) async {
//   try {
//     await OpenFile.open(filePath);
//   } catch (e) {
//     Get.snackbar('Error', 'Could not open file: $e',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white);
//   }
// }

// // Add method to clear old downloads
// void clearOldDownloads() {
//   _recentDownloads.removeWhere((download) {
//     final timestamp = download['timestamp'] as DateTime;
//     return DateTime.now().difference(timestamp).inDays > 7;
//   });
// }



//   final _profile = Rxn<ProfileModel>();
//   final _skills = <SkillModel>[].obs;
//   final _projects = <ProjectModel>[].obs;
//   final _experiences = <ExperienceModel>[].obs;
//   final _hobbies = <HobbyModel>[].obs;
//   final _educations = <EducationModel>[].obs;
//   final _achievements = <AchievementModel>[].obs;
//   final _isLoading = false.obs;
//   final _selectedTemplate = 1.obs;

//   ProfileModel? get profile => _profile.value;
//   List<SkillModel> get skills => _skills;
//   List<ProjectModel> get projects => _projects;
//   List<ExperienceModel> get experiences => _experiences;
//   List<HobbyModel> get hobbies => _hobbies;
//   List<EducationModel> get educations => _educations;
//   List<AchievementModel> get achievements => _achievements;
//   bool get isLoading => _isLoading.value;
//   int get selectedTemplate => _selectedTemplate.value;

//   @override
//   void onInit() {
//     super.onInit();
//     loadData();
//   }

//   void loadData() {
//     _profile.value = StorageService.getProfile();
//     _skills.value = StorageService.getSkills();
//     _projects.value = StorageService.getProjects();
//     _experiences.value = StorageService.getExperiences();
//     _hobbies.value = StorageService.getHobbies();
//     _educations.value = StorageService.getEducations();
//     _achievements.value = StorageService.getAchievements();
//   }

//   void setTemplate(int templateNumber) {
//     _selectedTemplate.value = templateNumber;
//   }

//   // Profile Methods
//   void updateProfile(ProfileModel profile) {
//     _profile.value = profile;
//     StorageService.saveProfile(profile);
//   }

//   Future<void> pickProfileImage() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );

//       if (image != null) {
//         final currentProfile = _profile.value ?? ProfileModel();
//         final updatedProfile = ProfileModel(
//           fullName: currentProfile.fullName,
//           professionalTitle: currentProfile.professionalTitle,
//           bio: currentProfile.bio,
//           phoneNumber: currentProfile.phoneNumber,
//           email: currentProfile.email,
//           address: currentProfile.address,
//           website: currentProfile.website,
//           linkedin: currentProfile.linkedin,
//           github: currentProfile.github,
//           profileImagePath: image.path,
//         );
//         updateProfile(updatedProfile);
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to pick image: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//     }
//   }

//   // Skills Methods
//   void addSkill(String skillName) {
//     if (skillName.trim().isEmpty) return;
//     final skill = SkillModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: skillName.trim(),
//     );
//     _skills.add(skill);
//     StorageService.saveSkills(_skills);
//   }

//   void removeSkill(String skillId) {
//     _skills.removeWhere((skill) => skill.id == skillId);
//     StorageService.saveSkills(_skills);
//   }

//   // Projects Methods
//   void addProject(ProjectModel project) {
//     _projects.add(project);
//     StorageService.saveProjects(_projects);
//   }

//   void removeProject(String projectId) {
//     _projects.removeWhere((project) => project.id == projectId);
//     StorageService.saveProjects(_projects);
//   }

//   void updateProject(ProjectModel updatedProject) {
//     final index = _projects.indexWhere((p) => p.id == updatedProject.id);
//     if (index != -1) {
//       _projects[index] = updatedProject;
//       StorageService.saveProjects(_projects);
//     }
//   }

//   // Experience Methods
//   void addExperience(ExperienceModel experience) {
//     _experiences.add(experience);
//     StorageService.saveExperiences(_experiences);
//   }

//   void removeExperience(String experienceId) {
//     _experiences.removeWhere((exp) => exp.id == experienceId);
//     StorageService.saveExperiences(_experiences);
//   }

//   void updateExperience(ExperienceModel updatedExperience) {
//     final index =
//         _experiences.indexWhere((e) => e.id == updatedExperience.id);
//     if (index != -1) {
//       _experiences[index] = updatedExperience;
//       StorageService.saveExperiences(_experiences);
//     }
//   }

//   // Hobbies Methods
//   void addHobby(String hobbyName) {
//     if (hobbyName.trim().isEmpty) return;
//     final hobby = HobbyModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: hobbyName.trim(),
//     );
//     _hobbies.add(hobby);
//     StorageService.saveHobbies(_hobbies);
//   }

//   void removeHobby(String hobbyId) {
//     _hobbies.removeWhere((hobby) => hobby.id == hobbyId);
//     StorageService.saveHobbies(_hobbies);
//   }

//   // Education Methods
//   void addEducation(EducationModel education) {
//     _educations.add(education);
//     StorageService.saveEducations(_educations);
//   }

//   void removeEducation(String educationId) {
//     _educations.removeWhere((edu) => edu.id == educationId);
//     StorageService.saveEducations(_educations);
//   }

//   void updateEducation(EducationModel updatedEducation) {
//     final index = _educations.indexWhere((e) => e.id == updatedEducation.id);
//     if (index != -1) {
//       _educations[index] = updatedEducation;
//       StorageService.saveEducations(_educations);
//     }
//   }

//   // Achievements Methods
//   void addAchievement(AchievementModel achievement) {
//     _achievements.add(achievement);
//     StorageService.saveAchievements(_achievements);
//   }

//   void removeAchievement(String achievementId) {
//     _achievements.removeWhere((ach) => ach.id == achievementId);
//     StorageService.saveAchievements(_achievements);
//   }

//   void updateAchievement(AchievementModel updatedAchievement) {
//     final index =
//         _achievements.indexWhere((a) => a.id == updatedAchievement.id);
//     if (index != -1) {
//       _achievements[index] = updatedAchievement;
//       StorageService.saveAchievements(_achievements);
//     }
//   }

//   // Validation
//   bool isProfileComplete() {
//     if (_profile.value == null) return false;
//     final p = _profile.value!;
//     if (p.fullName == null || p.fullName!.isEmpty) return false;
//     if (p.email == null || p.email!.isEmpty) return false;
//     return true;
//   }

//   String? getProfileCompletenessMessage() {
//     if (_profile.value == null) {
//       return 'Please fill in your profile first';
//     }
//     final p = _profile.value!;
//     if (p.fullName == null || p.fullName!.isEmpty) {
//       return 'Please add your Full Name';
//     }
//     if (p.email == null || p.email!.isEmpty) {
//       return 'Please add your Email';
//     }
//     return null;
//   }

//   // PDF Generation
//   Future<void> generateAndSavePdf({int? templateNumber}) async {
//     final message = getProfileCompletenessMessage();
//     if (message != null) {
//       Get.snackbar('Incomplete Profile', message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//       return;
//     }

//     _isLoading.value = true;
//     try {
//       final template = templateNumber ?? _selectedTemplate.value;
//       final pdfBytes = await PdfService.generatePortfolioPdf(
//         profile: _profile.value!,
//         skills: _skills,
//         projects: _projects,
//         experiences: _experiences,
//         hobbies: _hobbies,
//         educations: _educations,
//         achievements: _achievements,
//         profileImagePath: _profile.value!.profileImagePath,
//         templateNumber: template,
//       );

//       final fileName =
//           'portfolio_${DateTime.now().millisecondsSinceEpoch}';
//       await PdfService.savePdf(pdfBytes, fileName);

//       Get.snackbar('Success', 'PDF saved successfully',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to generate PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//     } finally {
//       _isLoading.value = false;
//     }
//   }

//   Future<void> generateAndSharePdf({int? templateNumber}) async {
//     final message = getProfileCompletenessMessage();
//     if (message != null) {
//       Get.snackbar('Incomplete Profile', message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//       return;
//     }

//     _isLoading.value = true;
//     try {
//       final template = templateNumber ?? _selectedTemplate.value;
//       final pdfBytes = await PdfService.generatePortfolioPdf(
//         profile: _profile.value!,
//         skills: _skills,
//         projects: _projects,
//         experiences: _experiences,
//         hobbies: _hobbies,
//         educations: _educations,
//         achievements: _achievements,
//         profileImagePath: _profile.value!.profileImagePath,
//         templateNumber: template,
//       );

//       await PdfService.sharePdf(pdfBytes);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to share PDF: $e',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white);
//     } finally {
//       _isLoading.value = false;
//     }
//   }
// }


import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/hobby_model.dart';
import '../models/education_model.dart';
import '../models/achievement_model.dart';
import '../services/storage_service.dart';
import '../services/pdf_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class PortfolioController extends GetxController {
  final _profile = Rxn<ProfileModel>();
  final _skills = <SkillModel>[].obs;
  final _projects = <ProjectModel>[].obs;
  final _experiences = <ExperienceModel>[].obs;
  final _hobbies = <HobbyModel>[].obs;
  final _educations = <EducationModel>[].obs;
  final _achievements = <AchievementModel>[].obs;
  final _isLoading = false.obs;
  final _selectedTemplate = 1.obs;
  
  // Download tracking variables
  final _downloadProgress = <String, double>{}.obs;
  final _recentDownloads = <Map<String, dynamic>>[].obs;

  // Getters
  ProfileModel? get profile => _profile.value;
  List<SkillModel> get skills => _skills;
  List<ProjectModel> get projects => _projects;
  List<ExperienceModel> get experiences => _experiences;
  List<HobbyModel> get hobbies => _hobbies;
  List<EducationModel> get educations => _educations;
  List<AchievementModel> get achievements => _achievements;
  bool get isLoading => _isLoading.value;
  int get selectedTemplate => _selectedTemplate.value;
  Map<String, double> get downloadProgress => _downloadProgress;
  List<Map<String, dynamic>> get recentDownloads => _recentDownloads;

  @override
  void onInit() {
    super.onInit();
    loadData();
    _loadDownloadHistory();
  }

  void loadData() {
    _profile.value = StorageService.getProfile();
    _skills.value = StorageService.getSkills();
    _projects.value = StorageService.getProjects();
    _experiences.value = StorageService.getExperiences();
    _hobbies.value = StorageService.getHobbies();
    _educations.value = StorageService.getEducations();
    _achievements.value = StorageService.getAchievements();
  }

  void _loadDownloadHistory() {
    // Load saved download history from storage if needed
    final savedDownloads = StorageService.getDownloadHistory();
    if (savedDownloads.isNotEmpty) {
      _recentDownloads.value = savedDownloads;
    }
  }

  void setTemplate(int templateNumber) {
    _selectedTemplate.value = templateNumber;
  }

  // Profile Methods
  void updateProfile(ProfileModel profile) {
    _profile.value = profile;
    StorageService.saveProfile(profile);
  }

  Future<void> pickProfileImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final currentProfile = _profile.value ?? ProfileModel();
        final updatedProfile = ProfileModel(
          fullName: currentProfile.fullName,
          professionalTitle: currentProfile.professionalTitle,
          bio: currentProfile.bio,
          phoneNumber: currentProfile.phoneNumber,
          email: currentProfile.email,
          address: currentProfile.address,
          website: currentProfile.website,
          linkedin: currentProfile.linkedin,
          github: currentProfile.github,
          profileImagePath: image.path,
        );
        updateProfile(updatedProfile);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Skills Methods
  void addSkill(String skillName) {
    if (skillName.trim().isEmpty) return;
    final skill = SkillModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: skillName.trim(),
    );
    _skills.add(skill);
    StorageService.saveSkills(_skills);
  }

  void removeSkill(String skillId) {
    _skills.removeWhere((skill) => skill.id == skillId);
    StorageService.saveSkills(_skills);
  }

  // Projects Methods
  void addProject(ProjectModel project) {
    _projects.add(project);
    StorageService.saveProjects(_projects);
  }

  void removeProject(String projectId) {
    _projects.removeWhere((project) => project.id == projectId);
    StorageService.saveProjects(_projects);
  }

  void updateProject(ProjectModel updatedProject) {
    final index = _projects.indexWhere((p) => p.id == updatedProject.id);
    if (index != -1) {
      _projects[index] = updatedProject;
      StorageService.saveProjects(_projects);
    }
  }

  // Experience Methods
  void addExperience(ExperienceModel experience) {
    _experiences.add(experience);
    StorageService.saveExperiences(_experiences);
  }

  void removeExperience(String experienceId) {
    _experiences.removeWhere((exp) => exp.id == experienceId);
    StorageService.saveExperiences(_experiences);
  }

  void updateExperience(ExperienceModel updatedExperience) {
    final index =
        _experiences.indexWhere((e) => e.id == updatedExperience.id);
    if (index != -1) {
      _experiences[index] = updatedExperience;
      StorageService.saveExperiences(_experiences);
    }
  }

  // Hobbies Methods
  void addHobby(String hobbyName) {
    if (hobbyName.trim().isEmpty) return;
    final hobby = HobbyModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: hobbyName.trim(),
    );
    _hobbies.add(hobby);
    StorageService.saveHobbies(_hobbies);
  }

  void removeHobby(String hobbyId) {
    _hobbies.removeWhere((hobby) => hobby.id == hobbyId);
    StorageService.saveHobbies(_hobbies);
  }

  // Education Methods
  void addEducation(EducationModel education) {
    _educations.add(education);
    StorageService.saveEducations(_educations);
  }

  void removeEducation(String educationId) {
    _educations.removeWhere((edu) => edu.id == educationId);
    StorageService.saveEducations(_educations);
  }

  void updateEducation(EducationModel updatedEducation) {
    final index = _educations.indexWhere((e) => e.id == updatedEducation.id);
    if (index != -1) {
      _educations[index] = updatedEducation;
      StorageService.saveEducations(_educations);
    }
  }

  // Achievements Methods
  void addAchievement(AchievementModel achievement) {
    _achievements.add(achievement);
    StorageService.saveAchievements(_achievements);
  }

  void removeAchievement(String achievementId) {
    _achievements.removeWhere((ach) => ach.id == achievementId);
    StorageService.saveAchievements(_achievements);
  }

  void updateAchievement(AchievementModel updatedAchievement) {
    final index =
        _achievements.indexWhere((a) => a.id == updatedAchievement.id);
    if (index != -1) {
      _achievements[index] = updatedAchievement;
      StorageService.saveAchievements(_achievements);
    }
  }

  // Validation
  bool isProfileComplete() {
    if (_profile.value == null) return false;
    final p = _profile.value!;
    if (p.fullName == null || p.fullName!.isEmpty) return false;
    if (p.email == null || p.email!.isEmpty) return false;
    return true;
  }

  String? getProfileCompletenessMessage() {
    if (_profile.value == null) {
      return 'Please fill in your profile first';
    }
    final p = _profile.value!;
    if (p.fullName == null || p.fullName!.isEmpty) {
      return 'Please add your Full Name';
    }
    if (p.email == null || p.email!.isEmpty) {
      return 'Please add your Email';
    }
    return null;
  }

  // PDF Generation with tracking
  Future<void> generateAndSavePdfWithTracking({int? templateNumber}) async {
    final message = getProfileCompletenessMessage();
    if (message != null) {
      Get.snackbar('Incomplete Profile', message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    _isLoading.value = true;
    final template = templateNumber ?? _selectedTemplate.value;
    final downloadId = DateTime.now().millisecondsSinceEpoch.toString();
    
    try {
      // Add to recent downloads
      _downloadProgress[downloadId] = 0.0;
      _recentDownloads.insert(0, {
        'id': downloadId,
        'templateNumber': template,
        'templateName': _getTemplateName(template),
        'timestamp': DateTime.now(),
        'status': 'downloading',
        'filePath': null,
      });

      // Simulate progress (you can replace this with actual progress from PDF generation)
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 100));
        _downloadProgress[downloadId] = i / 10;
      }

      final pdfBytes = await PdfService.generatePortfolioPdf(
        profile: _profile.value!,
        skills: _skills,
        projects: _projects,
        experiences: _experiences,
        hobbies: _hobbies,
        educations: _educations,
        achievements: _achievements,
        profileImagePath: _profile.value!.profileImagePath,
        templateNumber: template,
      );

      final fileName = 'portfolio_template${template}_${DateTime.now().millisecondsSinceEpoch}';
      final filePath = await PdfService.savePdf(pdfBytes, fileName);
      
      // Update download status
      _downloadProgress[downloadId] = 1.0;
      final index = _recentDownloads.indexWhere((d) => d['id'] == downloadId);
      if (index != -1) {
        _recentDownloads[index] = {
          'id': downloadId,
          'templateNumber': template,
          'templateName': _getTemplateName(template),
          'timestamp': DateTime.now(),
          'status': 'completed',
          'filePath': filePath,
        };
      }

      // Save download history
      _saveDownloadHistory();

      Get.snackbar('Success', 'PDF saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      // Update download status to failed
      final index = _recentDownloads.indexWhere((d) => d['id'] == downloadId);
      if (index != -1) {
        _recentDownloads[index] = {
          ..._recentDownloads[index],
          'status': 'failed',
        };
      }
      
      Get.snackbar('Error', 'Failed to generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }

  // Original PDF generation method (kept for backward compatibility)
  Future<void> generateAndSavePdf({int? templateNumber}) async {
    final message = getProfileCompletenessMessage();
    if (message != null) {
      Get.snackbar('Incomplete Profile', message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    _isLoading.value = true;
    try {
      final template = templateNumber ?? _selectedTemplate.value;
      final pdfBytes = await PdfService.generatePortfolioPdf(
        profile: _profile.value!,
        skills: _skills,
        projects: _projects,
        experiences: _experiences,
        hobbies: _hobbies,
        educations: _educations,
        achievements: _achievements,
        profileImagePath: _profile.value!.profileImagePath,
        templateNumber: template,
      );

      final fileName = 'portfolio_${DateTime.now().millisecondsSinceEpoch}';
      await PdfService.savePdf(pdfBytes, fileName);

      Get.snackbar('Success', 'PDF saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> generateAndSharePdf({int? templateNumber}) async {
    final message = getProfileCompletenessMessage();
    if (message != null) {
      Get.snackbar('Incomplete Profile', message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    _isLoading.value = true;
    try {
      final template = templateNumber ?? _selectedTemplate.value;
      final pdfBytes = await PdfService.generatePortfolioPdf(
        profile: _profile.value!,
        skills: _skills,
        projects: _projects,
        experiences: _experiences,
        hobbies: _hobbies,
        educations: _educations,
        achievements: _achievements,
        profileImagePath: _profile.value!.profileImagePath,
        templateNumber: template,
      );

      await PdfService.sharePdf(pdfBytes);
    } catch (e) {
      Get.snackbar('Error', 'Failed to share PDF: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      _isLoading.value = false;
    }
  }

  // Helper method to get template name
  String _getTemplateName(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return 'Classic Professional';
      case 2:
        return 'Modern Sidebar';
      case 3:
        return 'Minimalist';
      case 4:
        return 'Two Column';
      case 5:
        return 'Creative Colors';
      default:
        return 'Template $templateNumber';
    }
  }

  // Method to open downloaded file
  Future<void> openDownloadedFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        Get.snackbar('Error', 'Could not open file: ${result.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not open file: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // Method to remove a specific download
  void removeDownload(String downloadId) {
    _recentDownloads.removeWhere((d) => d['id'] == downloadId);
    _downloadProgress.remove(downloadId);
    _saveDownloadHistory();
  }

  // Method to clear old downloads (older than 7 days)
  void clearOldDownloads() {
    _recentDownloads.removeWhere((download) {
      final timestamp = download['timestamp'] as DateTime;
      return DateTime.now().difference(timestamp).inDays > 7;
    });
    
    // Also remove from progress map
    final idsToRemove = <String>[];
    _recentDownloads.forEach((download) {
      final timestamp = download['timestamp'] as DateTime;
      if (DateTime.now().difference(timestamp).inDays > 7) {
        idsToRemove.add(download['id']);
      }
    });
    
    for (final id in idsToRemove) {
      _downloadProgress.remove(id);
    }
    
    _saveDownloadHistory();
  }

  // Method to clear all downloads
  void clearAllDownloads() {
    _recentDownloads.clear();
    _downloadProgress.clear();
    _saveDownloadHistory();
  }

  // Save download history to storage
  void _saveDownloadHistory() {
    // Only save completed downloads
    final completedDownloads = _recentDownloads
        .where((d) => d['status'] == 'completed')
        .toList();
    StorageService.saveDownloadHistory(completedDownloads);
  }

  // Get list of downloaded files
  List<Map<String, dynamic>> getCompletedDownloads() {
    return _recentDownloads
        .where((d) => d['status'] == 'completed')
        .toList();
  }

  // Check if a file exists
  Future<bool> checkFileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  // Retry failed download
  Future<void> retryDownload(String downloadId) async {
    final download = _recentDownloads.firstWhereOrNull((d) => d['id'] == downloadId);
    if (download != null) {
      final templateNumber = download['templateNumber'];
      await generateAndSavePdfWithTracking(templateNumber: templateNumber);
    }
  }
}


