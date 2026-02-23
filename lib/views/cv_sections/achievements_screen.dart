import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/achievement_model.dart';
import '../../widgets/banner_ad_widget.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: () => Get.toNamed('/add-achievement'),
        title: "Achievements",
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.achievements.isEmpty) {
                return const Center(child: Text('No achievements added yet'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.achievements.length,
                itemBuilder: (context, index) {
                  final ach = controller.achievements[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(ach.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (ach.date != null && ach.date!.isNotEmpty)
                            Text(
                              ach.date!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                          Text(ach.description),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.removeAchievement(ach.id);
                          Get.snackbar(
                            'Success',
                            'Achievement removed',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                      ),
                      onTap: () =>
                          Get.toNamed('/add-achievement', arguments: ach),
                    ),
                  );
                },
              );
            }),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}

class AddAchievementScreen extends StatefulWidget {
  const AddAchievementScreen({super.key});

  @override
  State<AddAchievementScreen> createState() => _AddAchievementScreenState();
}

class _AddAchievementScreenState extends State<AddAchievementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  bool _isEdit = false;
  String? _achievementId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is AchievementModel) {
      _isEdit = true;
      _achievementId = args.id;
      _titleController.text = args.title;
      _descriptionController.text = args.description;
      _dateController.text = args.date ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _saveAchievement() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<PortfolioController>();
      final achievement = AchievementModel(
        id: _achievementId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: _dateController.text.trim().isEmpty
            ? null
            : _dateController.text.trim(),
      );

      if (_isEdit) {
        controller.updateAchievement(achievement);
      } else {
        controller.addAchievement(achievement);
      }

      Get.back();
      Get.snackbar(
        'Success',
        _isEdit ? 'Achievement updated' : 'Achievement added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: _saveAchievement,
        title: _isEdit ? 'Edit Achievement' : 'Add Achievement'
      ),
    
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Achievement Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.emoji_events),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter achievement title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'e.g., January 2023',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
