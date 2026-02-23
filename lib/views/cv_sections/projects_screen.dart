import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../models/project_model.dart';
import '../../widgets/banner_ad_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
            appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: () => Get.toNamed('/add-project'),
        title: "Projects",
      ),
      
    
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.projects.isEmpty) {
                return const Center(
                  child: Text('No projects added yet'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.projects.length,
                itemBuilder: (context, index) {
                  final project = controller.projects[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(project.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(project.description),
                          const SizedBox(height: 4),
                          Text(
                            'Tech: ${project.technologies}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.removeProject(project.id);
                          Get.snackbar('Success', 'Project removed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        },
                      ),
                      onTap: () => Get.toNamed('/add-project',
                          arguments: project),
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

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _technologiesController = TextEditingController();
  final _linkController = TextEditingController();
  bool _isEdit = false;
  String? _projectId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is ProjectModel) {
      _isEdit = true;
      _projectId = args.id;
      _nameController.text = args.name;
      _descriptionController.text = args.description;
      _technologiesController.text = args.technologies;
      _linkController.text = args.projectLink ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _technologiesController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _saveProject() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<PortfolioController>();
      final project = ProjectModel(
        id: _projectId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        technologies: _technologiesController.text.trim(),
        projectLink: _linkController.text.trim().isEmpty
            ? null
            : _linkController.text.trim(),
      );

      if (_isEdit) {
        controller.updateProject(project);
      } else {
        controller.addProject(project);
      }

      Get.back();
      Get.snackbar('Success',
          _isEdit ? 'Project updated' : 'Project added',
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
        onRightTap: _saveProject,
        title: _isEdit ? 'Edit Project' : 'Add Project'
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
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter project name';
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
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _technologiesController,
                      decoration: const InputDecoration(
                        labelText: 'Technologies Used',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.code),
                        hintText: 'e.g., Flutter, Dart, Firebase',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter technologies';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _linkController,
                      decoration: const InputDecoration(
                        labelText: 'Project Link (Optional)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.link),
                      ),
                      keyboardType: TextInputType.url,
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
