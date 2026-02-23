import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../controllers/portfolio_controller.dart';
import '../../models/profile_model.dart';
import '../../widgets/banner_ad_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _professionalTitleController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<PortfolioController>();
    final profile = controller.profile;
    if (profile != null) {
      _fullNameController.text = profile.fullName ?? '';
      _professionalTitleController.text = profile.professionalTitle ?? '';
      _bioController.text = profile.bio ?? '';
      _phoneController.text = profile.phoneNumber ?? '';
      _emailController.text = profile.email ?? '';
      _addressController.text = profile.address ?? '';
      _websiteController.text = profile.website ?? '';
      _linkedinController.text = profile.linkedin ?? '';
      _githubController.text = profile.github ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _professionalTitleController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _linkedinController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<PortfolioController>();
      final profile = ProfileModel(
        fullName: _fullNameController.text.trim(),
        professionalTitle: _professionalTitleController.text.trim(),
        bio: _bioController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        website: _websiteController.text.trim(),
        linkedin: _linkedinController.text.trim(),
        github: _githubController.text.trim(),
        profileImagePath: controller.profile?.profileImagePath,
      );
      controller.updateProfile(profile);
      Get.back();
      Get.snackbar('Success', 'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
         appBar: CustomBlueAppBar(
          rightText: "Add",
        onRightTap: _saveProfile,
        title: "Profile",
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
                    // Profile Image
                    Center(
                      child: Obx(() {
                        final imagePath = controller.profile?.profileImagePath;
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[800],
                              backgroundImage: imagePath != null &&
                                      imagePath.isNotEmpty
                                  ? FileImage(File(imagePath))
                                  : null,
                              child: imagePath == null || imagePath.isEmpty
                                  ? const Icon(Icons.person, size: 60)
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt, size: 20),
                                  onPressed: () => controller.pickProfileImage(),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _professionalTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Professional Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio / About Me',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            !GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _websiteController,
                      decoration: const InputDecoration(
                        labelText: 'Website',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.language),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _linkedinController,
                      decoration: const InputDecoration(
                        labelText: 'LinkedIn',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.link),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _githubController,
                      decoration: const InputDecoration(
                        labelText: 'GitHub',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.code),
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
