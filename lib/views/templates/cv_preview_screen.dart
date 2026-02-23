import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../generate_cv/generate_cv_screen.dart';

class CvPreviewScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isPremium;

  const CvPreviewScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomBlueAppBar(
        rightText: "Edit",
        onRightTap: () => Get.to(() => const GenrateCvScreen()),
        title: title,
      ),
  
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 400,
                        width: 300,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                size: 80,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Failed to load preview',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isPremium)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Premium Template',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.to(() => const GenrateCvScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0048ff),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Use This Template',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}