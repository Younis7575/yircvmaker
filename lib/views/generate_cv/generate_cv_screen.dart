import 'package:cvmaker/views/downlaod/my_downloads_screen.dart';
import 'package:cvmaker/views/drawer/about_screen.dart';
import 'package:cvmaker/views/drawer/contact_screen.dart';
import 'package:cvmaker/views/drawer/help_screen.dart';
import 'package:cvmaker/views/drawer/privacy_policy_screen.dart';
import 'package:cvmaker/views/drawer/terms_conditions_screen.dart';
import 'package:cvmaker/widgets/app_bar.dart';
import 'package:cvmaker/widgets/custom_button.dart';
import 'package:cvmaker/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../widgets/banner_ad_widget.dart';

class GenrateCvScreen extends StatelessWidget {
  const GenrateCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomBlueAppBar(title: "Generate CV"),
 

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCard(
                    leading: const Icon(Icons.person, size: 32),
                    title: 'Profile',
                    subtitle: controller.profile?.fullName ?? 'Not set',
                    subtitleColor: controller.profile?.fullName != null
                        ? null
                        : Colors.grey,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/edit-profile'),
                  ),
                  const SizedBox(height: 12),

                  // Skills Card
                  CustomCard(
                    leading: const Icon(Icons.star, size: 32),
                    title: 'Skills',
                    subtitle: '${controller.skills.length} skill(s)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/skills'),
                  ),
                  const SizedBox(height: 12),

                  // Projects Card
                  CustomCard(
                    leading: const Icon(Icons.work, size: 32),
                    title: 'Projects',
                    subtitle: '${controller.projects.length} project(s)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/projects'),
                  ),
                  const SizedBox(height: 12),

                  // Experience Card
                  CustomCard(
                    leading: const Icon(Icons.business_center, size: 32),
                    title: 'Experience',
                    subtitle: '${controller.experiences.length} experience(s)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/experience'),
                  ),
                  const SizedBox(height: 12),

                  // Education Card
                  CustomCard(
                    leading: const Icon(Icons.school, size: 32),
                    title: 'Education',
                    subtitle: '${controller.educations.length} education(s)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/education'),
                  ),
                  const SizedBox(height: 12),

                  // Achievements Card
                  CustomCard(
                    leading: const Icon(Icons.emoji_events, size: 32),
                    title: 'Achievements',
                    subtitle:
                        '${controller.achievements.length} achievement(s)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/achievements'),
                  ),
                  const SizedBox(height: 12),

                  // Hobbies Card
                  CustomCard(
                    leading: const Icon(Icons.sports_esports, size: 32),
                    title: 'Hobbies',
                    subtitle: '${controller.hobbies.length} hobby(ies)',
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/hobbies'),
                  ),
                  const SizedBox(height: 24),

                  PrimaryButton(
                    onPressed: () {
                      if (!controller.isProfileComplete()) {
                        final message = controller
                            .getProfileCompletenessMessage();
                        Get.snackbar(
                          'Incomplete Profile',
                          message ?? 'Please complete your profile',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.toNamed('/preview');
                    },
                    icon: const Icon(Icons.preview),
                    label: 'Preview Portfolio',
                  ),

                  const SizedBox(height: 12),

                  PrimaryButton(
                    onPressed: () {
                      if (!controller.isProfileComplete()) {
                        final message = controller
                            .getProfileCompletenessMessage();
                        Get.snackbar(
                          'Incomplete Profile',
                          message ?? 'Please complete your profile',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.toNamed('/select-template');
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: 'Generate PDF',
                    isLoading: controller.isLoading,
                  ),

                  const SizedBox(height: 12),

                  SecondaryButton(
                    onPressed: () {
                      if (!controller.isProfileComplete()) {
                        final message = controller
                            .getProfileCompletenessMessage();
                        Get.snackbar(
                          'Incomplete Profile',
                          message ?? 'Please complete your profile',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.toNamed('/select-template-share');
                    },
                    icon: const Icon(Icons.share),
                    label: 'Share PDF',
                    isLoading: controller.isLoading,
                  ),
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
