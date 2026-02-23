import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/experience_model.dart';
import '../../widgets/banner_ad_widget.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
        appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: () => Get.toNamed('/add-experience'),
        title: "Experience",
      ),
    
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.experiences.isEmpty) {
                return const Center(
                  child: Text('No experience added yet'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.experiences.length,
                itemBuilder: (context, index) {
                  final exp = controller.experiences[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(exp.jobTitle),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exp.companyName),
                          const SizedBox(height: 4),
                          Text(
                            exp.duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(exp.description),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.removeExperience(exp.id);
                          Get.snackbar('Success', 'Experience removed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        },
                      ),
                      onTap: () => Get.toNamed('/add-experience',
                          arguments: exp),
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

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _jobTitleController = TextEditingController();
  final _companyController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isEdit = false;
  String? _experienceId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is ExperienceModel) {
      _isEdit = true;
      _experienceId = args.id;
      _jobTitleController.text = args.jobTitle;
      _companyController.text = args.companyName;
      _durationController.text = args.duration;
      _descriptionController.text = args.description;
    }
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<PortfolioController>();
      final experience = ExperienceModel(
        id: _experienceId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        jobTitle: _jobTitleController.text.trim(),
        companyName: _companyController.text.trim(),
        duration: _durationController.text.trim(),
        description: _descriptionController.text.trim(),
      );

      if (_isEdit) {
        controller.updateExperience(experience);
      } else {
        controller.addExperience(experience);
      }

      Get.back();
      Get.snackbar('Success',
          _isEdit ? 'Experience updated' : 'Experience added',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: _saveExperience,
        title: _isEdit ? 'Edit Experience' : 'Add Experience'
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
                      controller: _jobTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Job Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter job title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _companyController,
                      decoration: const InputDecoration(
                        labelText: 'Company Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter company name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        labelText: 'Duration',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'e.g., Jan 2020 - Dec 2022',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter duration';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 5,
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
