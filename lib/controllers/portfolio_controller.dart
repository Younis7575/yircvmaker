 
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
import 'package:open_file/open_file.dart';
import 'dart:io'; 
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

  // Banner shown when a CV download completes
  final RxBool showDownloadBanner = false.obs;
  final RxString downloadBannerMessage = ''.obs;

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
    final savedDownloads = StorageService.getDownloadHistory();
    debugPrint('Loading download history: ${savedDownloads.length} CVs found');
    if (savedDownloads.isNotEmpty) {
      _recentDownloads.value = savedDownloads;
      debugPrint('Loaded CVs: ${savedDownloads.map((d) => d['templateName']).toList()}');
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
        
        Get.snackbar(
          'Success',
          'Profile image updated',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
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

  // **IMPROVED PDF GENERATION METHOD**
  Future<void> generateAndSavePdf({int? templateNumber}) async {
    if (_isLoading.value) {
      Get.snackbar(
        'Please Wait',
        'PDF generation already in progress',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final message = getProfileCompletenessMessage();
    if (message != null) {
      Get.snackbar(
        'Incomplete Profile',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      // Show loading dialog
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      final template = templateNumber ?? _selectedTemplate.value;

      print('Generating PDF for template: $template');
      
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

      print('PDF generated successfully, bytes: ${pdfBytes.length}');

      final fileName =
          'CV_${_profile.value!.fullName?.replaceAll(" ", "_")}_${DateTime.now().millisecondsSinceEpoch}';

      final savedPath = await PdfService.savePdf(pdfBytes, fileName);
      
      print('PDF saved at: $savedPath');

      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Save to recent downloads
      await saveRecentActivity(
        templateNumber: template,
        filePath: savedPath,
      );

      // Show success dialog with options
      _showSuccessDialog(savedPath, template);

    } catch (e, stackTrace) {
      print('Error generating PDF: $e');
      print('Stack trace: $stackTrace');
      
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      
      Get.snackbar(
        'Error',
        'Failed to generate PDF: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // **NEW: Share PDF method**
  Future<void> generateAndSharePdf({int? templateNumber}) async {
    if (_isLoading.value) return;

    final message = getProfileCompletenessMessage();
    if (message != null) {
      Get.snackbar(
        'Incomplete Profile',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    _isLoading.value = true;

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

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

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      await PdfService.sharePdf(pdfBytes);
      
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar(
        'Error',
        'Failed to share PDF: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // **NEW: Success dialog with options**
  void _showSuccessDialog(String filePath, int templateNumber) {
    Get.dialog(
      AlertDialog(
        title: const Text('Download Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your CV has been generated successfully!'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'File saved at:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    filePath,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // use named route so the new home screen configuration is respected
              Get.toNamed('/downloads');
            },
            child: const Text('My Downloads'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openDownloadedFile(filePath);
            },
            child: const Text('View File'),
          ),
        ],
      ),
    );
  }

  // **IMPROVED: Open downloaded file**
  Future<void> openDownloadedFile(String filePath) async {
    try {
      print('Opening file: $filePath');
      final file = File(filePath);
      
      if (!await file.exists()) {
        Get.snackbar(
          'Error',
          'File not found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final result = await OpenFile.open(filePath);
      print('Open result: ${result.type} - ${result.message}');
      
      if (result.type != ResultType.done) {
        Get.snackbar(
          'Cannot Open File',
          'Please install a PDF viewer app to open this file',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      print('Error opening file: $e');
      Get.snackbar(
        'Error',
        'Could not open file: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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

  // Method to remove a specific download
  void removeDownload(String downloadId) {
    _recentDownloads.removeWhere((d) => d['id'] == downloadId);
    _downloadProgress.remove(downloadId);
    _saveDownloadHistory();
  }

  // Method to clear all downloads
  void clearAllDownloads() {
    _recentDownloads.clear();
    _downloadProgress.clear();
    _saveDownloadHistory();
  }

  // Method to remove a download item by index
  void removeDownloadItem(int index) {
    if (index >= 0 && index < _recentDownloads.length) {
      _recentDownloads.removeAt(index);
      _saveDownloadHistory();
    }
  }

  // Save download history to storage
  void _saveDownloadHistory() {
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

  // Save recent activity
  Future<void> saveRecentActivity({
    required int templateNumber,
    required String filePath,
  }) async {
    final activity = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'templateNumber': templateNumber,
      'templateName': _getTemplateName(templateNumber),
      'filePath': filePath,
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'completed',
    };

    _recentDownloads.insert(0, activity);
    debugPrint('📥 CV Saved: ${activity['templateName']} at $filePath');
    debugPrint('📊 Total CVs on device: ${_recentDownloads.length}');
    StorageService.saveDownloadHistory(_recentDownloads);

    // show a temporary banner message at bottom
    downloadBannerMessage.value = 'Your CV has been downloaded';
    showDownloadBanner.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      showDownloadBanner.value = false;
    });
  }
}

 