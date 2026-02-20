import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';

class DownloadProgressWidget extends StatelessWidget {
  final PortfolioController controller = Get.find<PortfolioController>();

  DownloadProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.recentDownloads.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        height: 80,
        color: Colors.grey[900],
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: controller.recentDownloads.length,
                itemBuilder: (context, index) {
                  final download = controller.recentDownloads[index];
                  final downloadId = download['id'];
                  final progress = controller.downloadProgress[downloadId] ?? 0.0;
                  
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  download['status'] == 'completed'
                                      ? Icons.check_circle
                                      : download['status'] == 'failed'
                                          ? Icons.error
                                          : Icons.downloading,
                                  color: download['status'] == 'completed'
                                      ? Colors.green
                                      : download['status'] == 'failed'
                                          ? Colors.red
                                          : Colors.blue,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    download['templateName'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            // Cancel/Close button
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 14),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  controller.removeDownloadItem(index);
                                },
                                tooltip: 'Dismiss',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        if (download['status'] == 'downloading')
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[700],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        if (download['status'] == 'completed')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: () => controller.openDownloadedFile(
                                    download['filePath']),
                                icon: const Icon(Icons.open_in_new, size: 14),
                                label: const Text('Open', style: TextStyle(fontSize: 10)),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 0),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          ),
                        if (download['status'] == 'failed')
                          const Text(
                            'Download failed',
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Cancel All button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () => controller.clearAllDownloads(),
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Cancel All'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}