import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void _sendMessage() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    // Simulate sending message (replace with actual API if needed)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isSending = false);
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBlueAppBar(title: "Contact Us"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Send us a message and we will get back to you as soon as possible.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Contact Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value == null || !value.contains('@') ? 'Enter a valid email' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter subject' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your message' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isSending ? null : _sendMessage,
                    icon: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: Text(_isSending ? 'Sending...' : 'Send Message'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Info
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
            const SizedBox(height: 16),

            // Social Media
            const Text(
              'Follow Us on Social Media',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
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
                  icon: const Icon(Icons.social_distance, color: Colors.blueAccent),
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