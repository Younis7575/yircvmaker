import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // Function to open URLs
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: const CustomBlueAppBar(title: "Help & Contact"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Usage Instructions
            const Text(
              'How to Use Portfolio Maker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Navigate through sections to complete your CV.\n'
              '• Generate PDF once your profile is complete.\n'
              '• Use the Share option to send your CV via email or apps.\n'
              '• Track recently created CVs for quick access.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Contact Information
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text('hr.yirsystem@gmail.com'),
              onTap: () => _launchURL('mailto:hr.yirsystem@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text('+92 334 232 2324'),
              onTap: () => _launchURL('tel:+923342322324'),
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.orange),
              title: const Text('https://yir-systems.vercel.app/'),
              onTap: () => _launchURL('https://yir-systems.vercel.app/'),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text('Islamabad, Pakistan'),
            ),
            const SizedBox(height: 24),

            // Social Media
            const Text(
              'Follow Us on Social Media',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  onPressed: () => _launchURL('https://www.facebook.com/YIRSystem'),
                  tooltip: 'Facebook',
                ),
                IconButton(
                  icon: const Icon(Icons.alternate_email, color: Colors.lightBlue),
                  onPressed: () => _launchURL('https://twitter.com/YIRSystem'),
                  tooltip: 'Twitter',
                ),
                IconButton(
                  icon: const Icon(Icons.linked_camera_outlined, color: Colors.blueAccent),
                  onPressed: () => _launchURL('https://www.linkedin.com/company/yir-system/'),
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.pink),
                  onPressed: () => _launchURL('https://www.instagram.com/yirsystem/'),
                  tooltip: 'Instagram',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}