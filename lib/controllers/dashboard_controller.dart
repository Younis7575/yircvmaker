// lib/controllers/dashboard_controller.dart
import 'package:get/get.dart';
import 'package:cvmaker/services/appwrite_storage_service.dart';
import 'package:appwrite/models.dart';
import '../services/storage_service.dart';

class DashboardController extends GetxController {
  // Downloaded CVs
  RxList recentDownloads = <Map<String, dynamic>>[].obs;

  // Appwrite Templates
  RxList<File> templates = <File>[].obs;
  RxBool loadingTemplates = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDownloads();
    fetchTemplates();
  }

  void loadDownloads() {
    recentDownloads.value = StorageService.getDownloadHistory();
  }

  void fetchTemplates() async {
    loadingTemplates.value = true;
    try {
      final files = await AppwriteStorageService.getTemplates();
      templates.value = files;
    } catch (e) {
      print("Error fetching templates: $e");
    }
    loadingTemplates.value = false;
  }

  void refreshDownloads() {
    loadDownloads();
  }
}