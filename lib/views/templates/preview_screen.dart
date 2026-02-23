import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../controllers/portfolio_controller.dart';
import '../../widgets/banner_ad_widget.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});
 
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final templateColor = _getTemplateColor(controller.selectedTemplate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Preview'),
        actions: [
          Obx(() => IconButton(
                icon: controller.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.picture_as_pdf),
                onPressed: controller.isLoading
                    ? null
                    : () {
                      if (!controller.isProfileComplete()) {
                        final message = controller.getProfileCompletenessMessage();
                        Get.snackbar('Incomplete Profile', message ?? 'Please complete your profile',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        return;
                      }
                      Get.toNamed('/select-template-share');
                    },
                tooltip: 'Generate PDF',
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final profile = controller.profile;
                if (profile == null) {
                  return const Center(
                    child: Text('Please fill in your profile first'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Header
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Profile Image
                            if (profile.profileImagePath != null &&
                                profile.profileImagePath!.isNotEmpty)
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: templateColor.withOpacity(0.8),
                                backgroundImage: FileImage(
                                  File(profile.profileImagePath!),
                                ),
                              )
                            else
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: templateColor.withOpacity(0.5),
                                child: const Icon(Icons.person, size: 60),
                              ),
                            const SizedBox(height: 16),
                            Text(
                              profile.fullName ?? 'Your Name',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (profile.professionalTitle != null &&
                                profile.professionalTitle!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                profile.professionalTitle!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // About Section
                    if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'About Me',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                profile.bio!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Contact Information
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (profile.email != null &&
                                profile.email!.isNotEmpty)
                              _buildContactItem(Icons.email, profile.email!),
                            if (profile.phoneNumber != null &&
                                profile.phoneNumber!.isNotEmpty)
                              _buildContactItem(
                                  Icons.phone, profile.phoneNumber!),
                            if (profile.address != null &&
                                profile.address!.isNotEmpty)
                              _buildContactItem(
                                  Icons.location_on, profile.address!),
                            if (profile.website != null &&
                                profile.website!.isNotEmpty)
                              _buildContactItem(
                                  Icons.language, profile.website!),
                            if (profile.linkedin != null &&
                                profile.linkedin!.isNotEmpty)
                              _buildContactItem(
                                  Icons.link, profile.linkedin!),
                            if (profile.github != null &&
                                profile.github!.isNotEmpty)
                              _buildContactItem(Icons.code, profile.github!),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Skills Section
                    if (controller.skills.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Skills',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: controller.skills.map((skill) {
                                  return Chip(
                                    label: Text(skill.name,style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.grey[800],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Experience Section
                    if (controller.experiences.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...controller.experiences.map((exp) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        exp.jobTitle,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${exp.companyName} | ${exp.duration}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        exp.description,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Education Section
                    if (controller.educations.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Education',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...controller.educations.map((edu) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        edu.degree,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${edu.institution} | ${edu.duration}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      if (edu.description != null &&
                                          edu.description!.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          edu.description!,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Projects Section
                    if (controller.projects.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Projects',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...controller.projects.map((project) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Technologies: ${project.technologies}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        project.description,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      if (project.projectLink != null &&
                                          project.projectLink!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Link: ${project.projectLink}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue[300],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Achievements Section
                    if (controller.achievements.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Achievements',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...controller.achievements.map((ach) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ach.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (ach.date != null &&
                                          ach.date!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          ach.date!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      Text(
                                        ach.description,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Hobbies Section
                    if (controller.hobbies.isNotEmpty) ...[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hobbies',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: controller.hobbies.map((hobby) {
                                  return Chip(
                                    label: Text(hobby.name,style: const TextStyle(color: Colors.white),),
                                    backgroundColor: Colors.grey[800],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              }),
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
