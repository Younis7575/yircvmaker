import 'package:cvmaker/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cvmaker/models/profile_model.dart';
import 'package:cvmaker/models/skill_model.dart';
import 'package:cvmaker/models/project_model.dart';
import 'package:cvmaker/models/experience_model.dart';
import 'package:cvmaker/models/hobby_model.dart';
import 'package:cvmaker/models/education_model.dart';
import 'package:cvmaker/models/achievement_model.dart';
import 'package:cvmaker/services/storage_service.dart';
import 'package:cvmaker/services/pdf_service.dart';
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

  ProfileModel? get profile => _profile.value;
  List<SkillModel> get skills => _skills;
  List<ProjectModel> get projects => _projects;
  List<ExperienceModel> get experiences => _experiences;
  List<HobbyModel> get hobbies => _hobbies;
  List<EducationModel> get educations => _educations;
  List<AchievementModel> get achievements => _achievements;
  bool get isLoading => _isLoading.value;
  int get selectedTemplate => _selectedTemplate.value;

  @override
  void onInit() {
    super.onInit();
    loadData();
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

  // PDF Generation
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

      final fileName =
          'portfolio_${DateTime.now().millisecondsSinceEpoch}';
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
}
