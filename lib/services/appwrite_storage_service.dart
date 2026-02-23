// lib/services/appwrite_storage_service.dart
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import '../config/appwrite_config.dart';

class AppwriteStorageService {
  static final Client client = Client()
      .setEndpoint(AppwriteConfig.endpoint)
      .setProject(AppwriteConfig.projectId);

  static final Storage storage = Storage(client);

  /// Fetch all templates from bucket
  static Future<List<File>> getTemplates() async {
    final result = await storage.listFiles(bucketId: AppwriteConfig.bucketId);
    return result.files;
  }

  /// Get public URL for image
  static String getImageUrl(String fileId) {
    return "${AppwriteConfig.endpoint}/storage/buckets/"
        "${AppwriteConfig.bucketId}/files/$fileId/view?project=${AppwriteConfig.projectId}";
  }
}