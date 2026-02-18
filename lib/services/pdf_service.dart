import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/hobby_model.dart';
import '../models/education_model.dart';
import '../models/achievement_model.dart';

class PdfService {
  static Future<Uint8List> generatePortfolioPdf({
    required ProfileModel profile,
    required List<SkillModel> skills,
    required List<ProjectModel> projects,
    required List<ExperienceModel> experiences,
    required List<HobbyModel> hobbies,
    required List<EducationModel> educations,
    required List<AchievementModel> achievements,
    String? profileImagePath,
    int templateNumber = 1,
  }) async {
    switch (templateNumber) {
      case 1:
        return _generateTemplate1(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
      case 2:
        return _generateTemplate2(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
      case 3:
        return _generateTemplate3(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
      case 4:
        return _generateTemplate4(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
      case 5:
        return _generateTemplate5(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
      default:
        return _generateTemplate1(
            profile, skills, projects, experiences, hobbies, educations,
            achievements, profileImagePath);
    }
  }

  static Future<pw.ImageProvider?> _loadImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) return null;
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        final imageBytes = await file.readAsBytes();
        return pw.MemoryImage(imageBytes);
      }
    } catch (e) {
      print('Error loading profile image: $e');
    }
    return null;
  }

  // Template 1: Classic Professional
  static Future<Uint8List> _generateTemplate1(
      ProfileModel profile,
      List<SkillModel> skills,
      List<ProjectModel> projects,
      List<ExperienceModel> experiences,
      List<HobbyModel> hobbies,
      List<EducationModel> educations,
      List<AchievementModel> achievements,
      String? profileImagePath) async {
    final pdf = pw.Document();
    final profileImage = await _loadImage(profileImagePath);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
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
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),

              // Contact Info
              _buildContactSection(profile),
              pw.SizedBox(height: 20),

              // About
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                _buildSectionTitle('About Me'),
                pw.SizedBox(height: 8),
                pw.Text(profile.bio!, style: const pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 20),
              ],

              // Education
              if (educations.isNotEmpty) ...[
                _buildSectionTitle('Education'),
                pw.SizedBox(height: 8),
                ...educations.map((edu) => _buildEducationItem(edu)),
                pw.SizedBox(height: 20),
              ],

              // Experience
              if (experiences.isNotEmpty) ...[
                _buildSectionTitle('Experience'),
                pw.SizedBox(height: 8),
                ...experiences.map((exp) => _buildExperienceItem(exp)),
                pw.SizedBox(height: 20),
              ],

              // Skills
              if (skills.isNotEmpty) ...[
                _buildSectionTitle('Skills'),
                pw.SizedBox(height: 8),
                pw.Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skills
                      .map((s) => _buildSkillChip(s.name, PdfColors.grey200))
                      .toList(),
                ),
                pw.SizedBox(height: 20),
              ],

              // Projects
              if (projects.isNotEmpty) ...[
                _buildSectionTitle('Projects'),
                pw.SizedBox(height: 8),
                ...projects.map((proj) => _buildProjectItem(proj)),
                pw.SizedBox(height: 20),
              ],

              // Achievements
              if (achievements.isNotEmpty) ...[
                _buildSectionTitle('Achievements'),
                pw.SizedBox(height: 8),
                ...achievements.map((ach) => _buildAchievementItem(ach)),
                pw.SizedBox(height: 20),
              ],

              // Hobbies
              if (hobbies.isNotEmpty) ...[
                _buildSectionTitle('Hobbies'),
                pw.SizedBox(height: 8),
                pw.Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: hobbies
                      .map((h) => _buildSkillChip(h.name, PdfColors.grey200))
                      .toList(),
                ),
              ],
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Template 2: Modern with Sidebar
  static Future<Uint8List> _generateTemplate2(
      ProfileModel profile,
      List<SkillModel> skills,
      List<ProjectModel> projects,
      List<ExperienceModel> experiences,
      List<HobbyModel> hobbies,
      List<EducationModel> educations,
      List<AchievementModel> achievements,
      String? profileImagePath) async {
    final pdf = pw.Document();
    final profileImage = await _loadImage(profileImagePath);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Row(
            children: [
              // Left Sidebar
              pw.Container(
                width: 150,
                color: PdfColors.blue900,
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (profileImage != null)
                      pw.Container(
                        width: 100,
                        height: 100,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: PdfColors.white,
                          image: pw.DecorationImage(
                            image: profileImage!,
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      pw.Container(
                        width: 100,
                        height: 100,
                        decoration: const pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: PdfColors.white,
                        ),
                      ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      profile.fullName ?? 'Your Name',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    if (profile.professionalTitle != null)
                      pw.Text(
                        profile.professionalTitle!,
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey300,
                        ),
                      ),
                    pw.SizedBox(height: 30),
                    _buildSidebarSection('Contact', [
                      if (profile.email != null) profile.email!,
                      if (profile.phoneNumber != null) profile.phoneNumber!,
                      if (profile.address != null) profile.address!,
                    ]),
                    if (skills.isNotEmpty) ...[
                      pw.SizedBox(height: 20),
                      _buildSidebarSection('Skills',
                          skills.map((s) => s.name).toList()),
                    ],
                    if (hobbies.isNotEmpty) ...[
                      pw.SizedBox(height: 20),
                      _buildSidebarSection('Hobbies',
                          hobbies.map((h) => h.name).toList()),
                    ],
                  ],
                ),
              ),

              // Main Content
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        _buildSectionTitle('About'),
                        pw.SizedBox(height: 8),
                        pw.Text(profile.bio!,
                            style: const pw.TextStyle(fontSize: 11)),
                        pw.SizedBox(height: 20),
                      ],
                      if (educations.isNotEmpty) ...[
                        _buildSectionTitle('Education'),
                        pw.SizedBox(height: 8),
                        ...educations.map((edu) => _buildEducationItem(edu)),
                        pw.SizedBox(height: 20),
                      ],
                      if (experiences.isNotEmpty) ...[
                        _buildSectionTitle('Experience'),
                        pw.SizedBox(height: 8),
                        ...experiences.map((exp) => _buildExperienceItem(exp)),
                        pw.SizedBox(height: 20),
                      ],
                      if (projects.isNotEmpty) ...[
                        _buildSectionTitle('Projects'),
                        pw.SizedBox(height: 8),
                        ...projects.map((proj) => _buildProjectItem(proj)),
                        pw.SizedBox(height: 20),
                      ],
                      if (achievements.isNotEmpty) ...[
                        _buildSectionTitle('Achievements'),
                        pw.SizedBox(height: 8),
                        ...achievements.map((ach) => _buildAchievementItem(ach)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Template 3: Minimalist
  static Future<Uint8List> _generateTemplate3(
      ProfileModel profile,
      List<SkillModel> skills,
      List<ProjectModel> projects,
      List<ExperienceModel> experiences,
      List<HobbyModel> hobbies,
      List<EducationModel> educations,
      List<AchievementModel> achievements,
      String? profileImagePath) async {
    final pdf = pw.Document();
    final profileImage = await _loadImage(profileImagePath);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(50),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // Centered Header
              if (profileImage != null)
                pw.Container(
                  width: 120,
                  height: 120,
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    border: pw.Border.all(color: PdfColors.grey800, width: 2),
                    image: pw.DecorationImage(
                      image: profileImage!,
                      fit: pw.BoxFit.cover,
                    ),
                  ),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                profile.fullName ?? 'Your Name',
                style: pw.TextStyle(
                  fontSize: 32,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 8),
              if (profile.professionalTitle != null)
                pw.Text(
                  profile.professionalTitle!,
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.grey600,
                    letterSpacing: 0.5,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              pw.SizedBox(height: 30),
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 30),

              // Content sections
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                _buildCenteredSection('About', profile.bio!),
                pw.SizedBox(height: 25),
              ],
              if (educations.isNotEmpty) ...[
                _buildCenteredSection('Education',
                    educations.map((e) => '${e.degree} - ${e.institution}').join('\n')),
                pw.SizedBox(height: 25),
              ],
              if (experiences.isNotEmpty) ...[
                _buildCenteredSection('Experience',
                    experiences.map((e) => '${e.jobTitle} at ${e.companyName}').join('\n')),
                pw.SizedBox(height: 25),
              ],
              if (skills.isNotEmpty) ...[
                pw.Text('Skills',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Wrap(
                  alignment: pw.WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: skills
                      .map((s) => _buildSkillChip(s.name, PdfColors.grey300))
                      .toList(),
                ),
                pw.SizedBox(height: 25),
              ],
              if (projects.isNotEmpty) ...[
                _buildCenteredSection('Projects',
                    projects.map((p) => p.name).join(' • ')),
                pw.SizedBox(height: 25),
              ],
              if (achievements.isNotEmpty) ...[
                _buildCenteredSection('Achievements',
                    achievements.map((a) => a.title).join('\n')),
                pw.SizedBox(height: 25),
              ],
              if (hobbies.isNotEmpty) ...[
                pw.Text('Hobbies',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(hobbies.map((h) => h.name).join(', '),
                    style: const pw.TextStyle(fontSize: 11),
                    textAlign: pw.TextAlign.center),
              ],
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Template 4: Two Column Layout
  static Future<Uint8List> _generateTemplate4(
      ProfileModel profile,
      List<SkillModel> skills,
      List<ProjectModel> projects,
      List<ExperienceModel> experiences,
      List<HobbyModel> hobbies,
      List<EducationModel> educations,
      List<AchievementModel> achievements,
      String? profileImagePath) async {
    final pdf = pw.Document();
    final profileImage = await _loadImage(profileImagePath);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Bar
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey800,
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                  children: [
                    if (profileImage != null)
                      pw.Container(
                        width: 80,
                        height: 80,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          color: PdfColors.white,
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
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                          if (profile.professionalTitle != null)
                            pw.Text(
                              profile.professionalTitle!,
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColors.grey300,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Two Column Layout
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left Column
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                          _buildSectionTitle('About'),
                          pw.SizedBox(height: 8),
                          pw.Text(profile.bio!,
                              style: const pw.TextStyle(fontSize: 10)),
                          pw.SizedBox(height: 20),
                        ],
                        if (educations.isNotEmpty) ...[
                          _buildSectionTitle('Education'),
                          pw.SizedBox(height: 8),
                          ...educations.map((edu) => _buildEducationItem(edu)),
                          pw.SizedBox(height: 20),
                        ],
                        if (skills.isNotEmpty) ...[
                          _buildSectionTitle('Skills'),
                          pw.SizedBox(height: 8),
                          pw.Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: skills
                                .map((s) =>
                                    _buildSkillChip(s.name, PdfColors.grey200))
                                .toList(),
                          ),
                          pw.SizedBox(height: 20),
                        ],
                        if (hobbies.isNotEmpty) ...[
                          _buildSectionTitle('Hobbies'),
                          pw.SizedBox(height: 8),
                          pw.Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: hobbies
                                .map((h) =>
                                    _buildSkillChip(h.name, PdfColors.grey200))
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  // Right Column
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (experiences.isNotEmpty) ...[
                          _buildSectionTitle('Experience'),
                          pw.SizedBox(height: 8),
                          ...experiences.map((exp) => _buildExperienceItem(exp)),
                          pw.SizedBox(height: 20),
                        ],
                        if (projects.isNotEmpty) ...[
                          _buildSectionTitle('Projects'),
                          pw.SizedBox(height: 8),
                          ...projects.map((proj) => _buildProjectItem(proj)),
                          pw.SizedBox(height: 20),
                        ],
                        if (achievements.isNotEmpty) ...[
                          _buildSectionTitle('Achievements'),
                          pw.SizedBox(height: 8),
                          ...achievements.map((ach) => _buildAchievementItem(ach)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Template 5: Creative with Colors
  static Future<Uint8List> _generateTemplate5(
      ProfileModel profile,
      List<SkillModel> skills,
      List<ProjectModel> projects,
      List<ExperienceModel> experiences,
      List<HobbyModel> hobbies,
      List<EducationModel> educations,
      List<AchievementModel> achievements,
      String? profileImagePath) async {
    final pdf = pw.Document();
    final profileImage = await _loadImage(profileImagePath);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // Colored Header
              pw.Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: pw.Container(
                  height: 150,
                  decoration: pw.BoxDecoration(
                    gradient: pw.LinearGradient(
                      colors: [PdfColors.blue700, PdfColors.cyan700],
                      begin: pw.Alignment.topLeft,
                      end: pw.Alignment.bottomRight,
                    ),
                  ),
                  padding: const pw.EdgeInsets.all(30),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (profileImage != null)
                        pw.Container(
                          width: 100,
                          height: 100,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            border: pw.Border.all(
                                color: PdfColors.white, width: 3),
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
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              profile.fullName ?? 'Your Name',
                              style: pw.TextStyle(
                                fontSize: 28,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                            if (profile.professionalTitle != null)
                              pw.Text(
                                profile.professionalTitle!,
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.grey200,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Content
              pw.Positioned(
                top: 130,
                left: 0,
                right: 0,
                bottom: 0,
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(30),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 20),
                      // Contact Info
                      _buildContactRow(profile),
                      pw.SizedBox(height: 20),

                      // Sections in cards
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        _buildCardSection('About Me', profile.bio!),
                        pw.SizedBox(height: 15),
                      ],
                      if (educations.isNotEmpty) ...[
                        _buildCardSection('Education',
                            educations.map((e) => '${e.degree} - ${e.institution} (${e.duration})').join('\n')),
                        pw.SizedBox(height: 15),
                      ],
                      if (experiences.isNotEmpty) ...[
                        _buildCardSection('Experience',
                            experiences.map((e) => '${e.jobTitle}\n${e.companyName} - ${e.duration}\n${e.description}').join('\n\n')),
                        pw.SizedBox(height: 15),
                      ],
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (skills.isNotEmpty)
                            pw.Expanded(
                              child: _buildCardSection('Skills',
                                  skills.map((s) => s.name).join(', ')),
                            ),
                          if (hobbies.isNotEmpty) ...[
                            pw.SizedBox(width: 15),
                            pw.Expanded(
                              child: _buildCardSection('Hobbies',
                                  hobbies.map((h) => h.name).join(', ')),
                            ),
                          ],
                        ],
                      ),
                      if (projects.isNotEmpty) ...[
                        pw.SizedBox(height: 15),
                        _buildCardSection('Projects',
                            projects.map((p) => '${p.name}\n${p.description}').join('\n\n')),
                      ],
                      if (achievements.isNotEmpty) ...[
                        pw.SizedBox(height: 15),
                        _buildCardSection('Achievements',
                            achievements.map((a) => '${a.title}\n${a.description}').join('\n\n')),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Helper Methods
  static pw.Widget _buildSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 18,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue700,
      ),
    );
  }

  static pw.Widget _buildContactSection(ProfileModel profile) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (profile.email != null && profile.email!.isNotEmpty)
          pw.Text('Email: ${profile.email}',
              style: const pw.TextStyle(fontSize: 10)),
        if (profile.phoneNumber != null && profile.phoneNumber!.isNotEmpty)
          pw.Text('Phone: ${profile.phoneNumber}',
              style: const pw.TextStyle(fontSize: 10)),
        if (profile.address != null && profile.address!.isNotEmpty)
          pw.Text('Address: ${profile.address}',
              style: const pw.TextStyle(fontSize: 10)),
        if (profile.website != null && profile.website!.isNotEmpty)
          pw.Text('Website: ${profile.website}',
              style: const pw.TextStyle(fontSize: 10)),
        if (profile.linkedin != null && profile.linkedin!.isNotEmpty)
          pw.Text('LinkedIn: ${profile.linkedin}',
              style: const pw.TextStyle(fontSize: 10)),
        if (profile.github != null && profile.github!.isNotEmpty)
          pw.Text('GitHub: ${profile.github}',
              style: const pw.TextStyle(fontSize: 10)),
      ],
    );
  }

  static pw.Widget _buildContactRow(ProfileModel profile) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        if (profile.email != null)
          pw.Text(profile.email!, style: const pw.TextStyle(fontSize: 9)),
        if (profile.phoneNumber != null)
          pw.Text(profile.phoneNumber!,
              style: const pw.TextStyle(fontSize: 9)),
      ],
    );
  }

  static pw.Widget _buildEducationItem(EducationModel edu) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            edu.degree,
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            '${edu.institution} | ${edu.duration}',
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey700,
            ),
          ),
          if (edu.description != null && edu.description!.isNotEmpty)
            pw.Text(edu.description!,
                style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  static pw.Widget _buildExperienceItem(ExperienceModel exp) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            exp.jobTitle,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            '${exp.companyName} | ${exp.duration}',
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey700,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(exp.description, style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  static pw.Widget _buildProjectItem(ProjectModel proj) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            proj.name,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'Technologies: ${proj.technologies}',
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.grey700,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(proj.description,
              style: const pw.TextStyle(fontSize: 10)),
          if (proj.projectLink != null && proj.projectLink!.isNotEmpty)
            pw.Text('Link: ${proj.projectLink}',
                style: pw.TextStyle(
                    fontSize: 10, color: PdfColors.blue700)),
        ],
      ),
    );
  }

  static pw.Widget _buildAchievementItem(AchievementModel ach) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            ach.title,
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          if (ach.date != null)
            pw.Text(ach.date!,
                style: pw.TextStyle(
                    fontSize: 10, color: PdfColors.grey700)),
          pw.SizedBox(height: 4),
          pw.Text(ach.description,
              style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  static pw.Widget _buildSkillChip(String text, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 9)),
    );
  }

  static pw.Widget _buildSidebarSection(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        pw.SizedBox(height: 8),
        ...items.map((item) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 5),
              child: pw.Text(
                item,
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey300),
              ),
            )),
      ],
    );
  }

  static pw.Widget _buildCenteredSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(title,
            style: pw.TextStyle(
                fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text(content,
            style: const pw.TextStyle(fontSize: 11),
            textAlign: pw.TextAlign.center),
      ],
    );
  }

  static pw.Widget _buildCardSection(String title, String content) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(5),
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title,
              style: pw.TextStyle(
                  fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Text(content, style: const pw.TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

static Future<String> savePdf(Uint8List pdfBytes, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$fileName.pdf');
  await file.writeAsBytes(pdfBytes);
  return file.path; // Return the file path
}

  static Future<void> sharePdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
