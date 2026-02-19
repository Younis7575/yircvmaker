import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class MyDownloadsScreen extends StatelessWidget {
  final PortfolioController controller = Get.find<PortfolioController>();

  MyDownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Downloads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _showClearAllDialog,
          ),
        ],
      ),
      body: Obx(() {
        final downloads = controller.recentDownloads;
        
        if (downloads.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_done,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No downloads yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your downloaded CVs will appear here',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: downloads.length,
          itemBuilder: (context, index) {
            final download = downloads[index];
            final filePath = download['filePath'] as String?;
            final file = filePath != null ? File(filePath) : null;
            final fileExists = file?.existsSync() ?? false;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getTemplateColor(download['templateNumber']),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  download['templateName'] ?? 'Template',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Downloaded: ${_formatDate(download['timestamp'])}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (!fileExists)
                      const Text(
                        'File not found',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    if (fileExists)
                      const PopupMenuItem(
                        value: 'open',
                        child: Row(
                          children: [
                            Icon(Icons.open_in_new),
                            SizedBox(width: 8),
                            Text('Open'),
                          ],
                        ),
                      ),
                    if (fileExists)
                      const PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 8),
                            Text('Share'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    switch (value) {
                      case 'open':
                        if (fileExists) {
                          await OpenFile.open(filePath);
                        }
                        break;
                      case 'share':
                        // Implement share functionality
                        break;
                      case 'delete':
                        _showDeleteDialog(download['id'], filePath);
                        break;
                    }
                  },
                ),
                onTap: fileExists
                    ? () => OpenFile.open(filePath)
                    : null,
              ),
            );
          },
        );
      }),
    );
  }

  Color _getTemplateColor(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    
    DateTime date;
    if (timestamp is DateTime) {
      date = timestamp;
    } else if (timestamp is String) {
      date = DateTime.parse(timestamp);
    } else {
      return 'Unknown';
    }
    
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showDeleteDialog(String downloadId, String? filePath) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Download'),
        content: const Text('Are you sure you want to delete this file?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Delete physical file
              if (filePath != null) {
                try {
                  final file = File(filePath);
                  if (await file.exists()) {
                    await file.delete();
                  }
                } catch (e) {
                  print('Error deleting file: $e');
                }
              }
              
              // Remove from list
              controller.removeDownload(downloadId);
              Get.back();
              
              Get.snackbar(
                'Deleted',
                'File has been deleted',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Downloads'),
        content: const Text('Are you sure you want to delete all downloaded files?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Delete all physical files
              for (var download in controller.recentDownloads) {
                final filePath = download['filePath'] as String?;
                if (filePath != null) {
                  try {
                    final file = File(filePath);
                    if (await file.exists()) {
                      await file.delete();
                    }
                  } catch (e) {
                    print('Error deleting file: $e');
                  }
                }
              }
              
              // Clear list
              controller.clearAllDownloads();
              Get.back();
              
              Get.snackbar(
                'Cleared',
                'All downloads have been deleted',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}