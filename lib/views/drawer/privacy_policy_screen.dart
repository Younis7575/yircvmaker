import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: const CustomBlueAppBar(title: "Privacy Policy"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Effective Date: February 22, 2026\n',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Portfolio Maker, developed by YIR System, values your privacy. '
              'This Privacy Policy explains how we collect, use, and protect your personal information.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '1. Information Collection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• We collect information you provide directly, such as your name, email, CV data, '
              'and other profile information.\n'
              '• We do not collect sensitive personal information unless explicitly provided.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '2. Use of Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• To generate and manage your CVs.\n'
              '• To improve app performance and user experience.\n'
              '• To provide support and communication related to your CVs.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '3. Sharing of Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• We do not sell or share your personal information with third parties '
              'except for services required to generate, store, or share your CVs.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '4. Data Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• We implement appropriate technical and organizational measures to secure your data.\n'
              '• However, no method of transmission over the internet is 100% secure.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '5. User Rights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• You can review, update, or delete your personal information within the app.\n'
              '• For additional requests, contact us at hr.yirsystem@gmail.com.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '6. Changes to Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• We may update this Privacy Policy from time to time.\n'
              '• Updated policies will be posted within the app.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '7. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• Email: hr.yirsystem@gmail.com\n'
              '• Phone: +92 334 232 2324\n'
              '• Website: https://yir-systems.vercel.app/\n'
              '• Location: Islamabad, Pakistan\n',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}