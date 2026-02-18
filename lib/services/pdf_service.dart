import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';

class PdfService {
  static Future<Uint8List> generatePortfolioPdf({
    required ProfileModel profile,
    required List<SkillModel> skills,
    required List<ProjectModel> projects,
    required List<ExperienceModel> experiences,
    String? profileImagePath,
  }) async {
    final pdf = pw.Document();

    pw.ImageProvider? profileImage;
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      try {
        final file = File(profileImagePath);
        if (await file.exists()) {
          final imageBytes = await file.readAsBytes();
          profileImage = pw.MemoryImage(imageBytes);
        }
      } catch (e) {
        print('Error loading profile image: $e');
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            // Header with Profile Image and Name
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (profileImage != null)
                  pw.Container(
                    width: 100,
                    height: 100,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                        image: profileImage!,
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                  ),
                pw.SizedBox(width: 20),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        profile.fullName ?? 'Your Name',
                        style: pw.TextStyle(
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      if (profile.professionalTitle != null &&
                          profile.professionalTitle!.isNotEmpty)
                        pw.Text(
                          profile.professionalTitle!,
                          style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColors.grey700,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // About Section
            if (profile.bio != null && profile.bio!.isNotEmpty) ...[
              pw.Text(
                'About Me',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                profile.bio!,
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
            ],

            // Contact Information
            pw.Row(
              children: [
                if (profile.email != null && profile.email!.isNotEmpty)
                  pw.Text(
                    'Email: ${profile.email}',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                if (profile.phoneNumber != null &&
                    profile.phoneNumber!.isNotEmpty)
                  pw.Text(
                    ' | Phone: ${profile.phoneNumber}',
                    style: const pw.TextStyle(fontSize: 11),
                  ),
              ],
            ),
            if (profile.address != null && profile.address!.isNotEmpty)
              pw.Text(
                'Address: ${profile.address}',
                style: const pw.TextStyle(fontSize: 11),
              ),
            if (profile.website != null && profile.website!.isNotEmpty)
              pw.Text(
                'Website: ${profile.website}',
                style: const pw.TextStyle(fontSize: 11),
              ),
            if (profile.linkedin != null && profile.linkedin!.isNotEmpty)
              pw.Text(
                'LinkedIn: ${profile.linkedin}',
                style: const pw.TextStyle(fontSize: 11),
              ),
            if (profile.github != null && profile.github!.isNotEmpty)
              pw.Text(
                'GitHub: ${profile.github}',
                style: const pw.TextStyle(fontSize: 11),
              ),
            pw.SizedBox(height: 20),

            // Skills Section
            if (skills.isNotEmpty) ...[
              pw.Text(
                'Skills',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) {
                  return pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(15),
                    ),
                    child: pw.Text(
                      skill.name,
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                  );
                }).toList(),
              ),
              pw.SizedBox(height: 20),
            ],

            // Experience Section
            if (experiences.isNotEmpty) ...[
              pw.Text(
                'Experience',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ...experiences.map((exp) {
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 15),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        exp.jobTitle,
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '${exp.companyName} | ${exp.duration}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        exp.description,
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                );
              }).toList(),
              pw.SizedBox(height: 20),
            ],

            // Projects Section
            if (projects.isNotEmpty) ...[
              pw.Text(
                'Projects',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              ...projects.map((project) {
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 15),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        project.name,
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Technologies: ${project.technologies}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        project.description,
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                      if (project.projectLink != null &&
                          project.projectLink!.isNotEmpty)
                        pw.Text(
                          'Link: ${project.projectLink}',
                          style: pw.TextStyle(
                            fontSize: 11,
                            color: PdfColors.blue700,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ];
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> savePdf(Uint8List pdfBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.pdf');
    await file.writeAsBytes(pdfBytes);
  }

  static Future<void> sharePdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
