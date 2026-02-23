import 'package:cvmaker/controllers/portfolio_controller.dart';
import 'package:cvmaker/widgets/app_bar.dart';
// download screen imported via routes, so explicit import not needed here
import 'package:cvmaker/widgets/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCvScreen extends StatelessWidget {
  const AddCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      appBar: const CustomBlueAppBar(title: "Add CV"),
    body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, size: 32),
                      title: const Text('Profile'),
                      subtitle: Text(
                        controller.profile?.fullName ?? 'Not set',
                        style: TextStyle(
                          color: controller.profile?.fullName != null
                              ? null
                              : Colors.grey,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/edit-profile'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Skills Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.star, size: 32),
                      title: const Text('Skills'),
                      subtitle: Text(
                        '${controller.skills.length} skill(s)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/skills'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Projects Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.work, size: 32),
                      title: const Text('Projects'),
                      subtitle: Text(
                        '${controller.projects.length} project(s)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/projects'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Experience Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.business_center, size: 32),
                      title: const Text('Experience'),
                      subtitle: Text(
                        '${controller.experiences.length} experience(s)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/experience'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Education Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.school, size: 32),
                      title: const Text('Education'),
                      subtitle: Text(
                        '${controller.educations.length} education(s)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/education'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Achievements Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events, size: 32),
                      title: const Text('Achievements'),
                      subtitle: Text(
                        '${controller.achievements.length} achievement(s)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/achievements'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Hobbies Card
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.sports_esports, size: 32),
                      title: const Text('Hobbies'),
                      subtitle: Text(
                        '${controller.hobbies.length} hobby(ies)',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Get.toNamed('/hobbies'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preview Button
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!controller.isProfileComplete()) {
                        final message = controller.getProfileCompletenessMessage();
                        Get.snackbar('Incomplete Profile', message ?? 'Please complete your profile',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                        return;
                      }
                      Get.toNamed('/preview');
                    },
                    icon: const Icon(Icons.preview),
                    label: const Text('Preview Portfolio'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Generate PDF Button
                  Obx(() => ElevatedButton.icon(
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
                              Get.toNamed('/select-template');
                            },
                        icon: controller.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.picture_as_pdf),
                        label: Text(controller.isLoading
                            ? 'Generating...'
                            : 'Generate PDF'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      )),
                  const SizedBox(height: 12),

                  // Share PDF Button
                  Obx(() => OutlinedButton.icon(
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
                        icon: const Icon(Icons.share),
                        label: const Text('Share PDF'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      )),
                ],
              ),
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
