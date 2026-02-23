import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBlueAppBar(title: "About"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Overview
            const Text(
              'About Portfolio Maker',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Portfolio Maker is a professional app developed by YIR System, '
              'designed to help users create, generate, and share their CVs '
              'quickly and efficiently. Whether you are a student, professional, '
              'or freelancer, this app allows you to showcase your skills, '
              'experience, and achievements in a well-organized portfolio.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Key Features
            const Text(
              'Key Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Create a professional CV with multiple sections including Profile, Skills, Projects, Education, Experience, Achievements, and Hobbies.\n'
              '• Preview your portfolio before generating PDF.\n'
              '• Generate PDF versions of your CV instantly.\n'
              '• Share your CV easily via email or social apps.\n'
              '• User-friendly interface with easy navigation.\n'
              '• Track recently created CVs for quick access.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // About Company
            const Text(
              'About YIR System',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'YIR System is a technology company committed to building '
              'innovative digital solutions that simplify professional tasks. '
              'Our goal is to provide high-quality apps that enhance productivity '
              'and empower users in their career development.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Contact Info
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '• Email: hr.yirsystem@gmail.com\n'
              '• Phone: +92 334 232 2324\n'
              '• https://yir-systems.vercel.app/\n'
              '• Islamabad, Pakistan',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Closing Note
            const Text(
              'Portfolio Maker empowers you to create professional CVs '
              'effortlessly. We are constantly improving our app to add more '
              'features and enhance user experience. Thank you for choosing us!',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
