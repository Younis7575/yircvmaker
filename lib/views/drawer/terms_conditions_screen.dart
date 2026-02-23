import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Terms & Conditions')),
      appBar: const CustomBlueAppBar(title: "Terms & Conditions"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Terms & Conditions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Effective Date: February 22, 2026\n',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'By using Portfolio Maker, developed by YIR System, you agree to the following terms and conditions. '
              'Please read them carefully before using the app.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '1. License',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• YIR System grants you a limited, non-exclusive, non-transferable license to use the Portfolio Maker app for personal and professional CV creation purposes.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '2. User Responsibilities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• You are responsible for the accuracy of the information provided in your CV.\n'
              '• You agree not to misuse the app or attempt to access any unauthorized areas.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '3. Intellectual Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• All designs, templates, and content provided by Portfolio Maker remain the property of YIR System.\n'
              '• You may not copy, distribute, or modify the app content without explicit permission.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '4. Limitation of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• YIR System is not liable for any errors, loss of data, or damages resulting from the use of this app.\n'
              '• Use the app at your own risk.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '5. Updates & Changes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• YIR System may update the app or terms at any time.\n'
              '• Users will be notified within the app when major changes occur.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '6. Governing Law',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '• These terms are governed by the laws of Pakistan.\n'
              '• Any disputes will be subject to the jurisdiction of courts in Islamabad, Pakistan.\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              '7. Contact Information',
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