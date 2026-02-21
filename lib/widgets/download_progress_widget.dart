import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';

class DownloadProgressWidget extends StatelessWidget {
  final PortfolioController controller = Get.find<PortfolioController>();

  DownloadProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.showDownloadBanner.value) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        height: 60, // cover typical bottom navigation bar
        color: Colors.black87,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          controller.downloadBannerMessage.value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}