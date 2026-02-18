import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../services/storage_service.dart';
import '../services/pdf_service.dart';
import 'package:flutter/material.dart';

class PortfolioController extends GetxController {
  final _profile = Rxn<ProfileModel>();
  final _skills = <SkillModel>[].obs;
  final _projects = <ProjectModel>[].obs;
  final _experiences = <ExperienceModel>[].obs;
  final _isLoading = false.obs;

  ProfileModel? get profile => _profile.value;
  List<SkillModel> get skills => _skills;
  List<ProjectModel> get projects => _projects;
  List<ExperienceModel> get experiences => _experiences;
  bool get isLoading => _isLoading.value;

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

  // PDF Generation
  Future<void> generateAndSavePdf() async {
    if (_profile.value == null) {
      Get.snackbar('Error', 'Please fill in your profile first',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    _isLoading.value = true;
    try {
      final pdfBytes = await PdfService.generatePortfolioPdf(
        profile: _profile.value!,
        skills: _skills,
        projects: _projects,
        experiences: _experiences,
        profileImagePath: _profile.value!.profileImagePath,
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

  Future<void> generateAndSharePdf() async {
    if (_profile.value == null) {
      Get.snackbar('Error', 'Please fill in your profile first',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    _isLoading.value = true;
    try {
      final pdfBytes = await PdfService.generatePortfolioPdf(
        profile: _profile.value!,
        skills: _skills,
        projects: _projects,
        experiences: _experiences,
        profileImagePath: _profile.value!.profileImagePath,
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
