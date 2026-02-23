import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/profile_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/hobby_model.dart';
import '../models/education_model.dart';
import '../models/achievement_model.dart';

class PdfService {
  // ─────────────────────────────────────────────────────────────
  //  MAIN ROUTER
  // ─────────────────────────────────────────────────────────────
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
    Uint8List? imgBytes;
    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      try {
        imgBytes = await File(profileImagePath).readAsBytes();
      } catch (_) {}
    }

    pw.Document doc;
    switch (templateNumber) {
      case 1:
        doc = _t1BlueClassicSidebar(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 2:
        doc = _t2DarkRedHero(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 3:
        doc = _t3BWMinimalist(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 4:
        doc = _t4GreenTopBar(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 5:
        doc = _t5TealCards(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 6:
        doc = _t6PurpleTimeline(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 7:
        doc = _t7OrangeInfographic(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 8:
        doc = _t8BWElegant(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 9:
        doc = _t9NavyGold(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      case 10:
        doc = _t10RedBoldModern(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
        break;
      default:
        doc = _t1BlueClassicSidebar(
          profile,
          skills,
          experiences,
          educations,
          projects,
          achievements,
          hobbies,
          imgBytes,
        );
    }
    return doc.save();
  }

  // ─────────────────────────────────────────────────────────────
  //  SAVE & SHARE
  // ─────────────────────────────────────────────────────────────
  static Future<String> savePdf(Uint8List bytes, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  static Future<void> sharePdf(Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cv_share.pdf');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: 'My CV');
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T1 – Classic Blue Sidebar
  //  Layout: Blue left sidebar + White right content
  //  Style : Professional, colored
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t1BlueClassicSidebar(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const blue = PdfColor.fromInt(0xFF1565C0);
    const bDark = PdfColor.fromInt(0xFF0D47A1);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF212121);
    const grey = PdfColor.fromInt(0xFF616161);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // ── SIDEBAR
            pw.Container(
              width: 178,
              color: blue,
              child: pw.Column(
                children: [
                  pw.Container(
                    color: bDark,
                    width: double.infinity,
                    padding: const pw.EdgeInsets.fromLTRB(14, 22, 14, 18),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _circleAvatar(img, 70, white, PdfColors.blue300, p),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.blue100,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(13),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _sbTitle('CONTACT', white, PdfColors.blue300),
                          if (p.email?.isNotEmpty == true)
                            _sbItem('✉  ${p.email}', white),
                          if (p.phoneNumber?.isNotEmpty == true)
                            _sbItem('☎  ${p.phoneNumber}', white),
                          if (p.address?.isNotEmpty == true)
                            _sbItem('⌂  ${p.address}', white),
                          if (p.linkedin?.isNotEmpty == true)
                            _sbItem('in  ${p.linkedin}', white),
                          if (p.github?.isNotEmpty == true)
                            _sbItem('git ${p.github}', white),
                          pw.SizedBox(height: 10),
                          if (sk.isNotEmpty) ...[
                            _sbTitle('SKILLS', white, PdfColors.blue300),
                            ...sk.map(
                              (s) =>
                                  _sbBullet(s.name, white, PdfColors.blue100),
                            ),
                            pw.SizedBox(height: 10),
                          ],
                          if (ho.isNotEmpty) ...[
                            _sbTitle('INTERESTS', white, PdfColors.blue300),
                            pw.Text(
                              ho.map((h) => h.name).join(' · '),
                              style: pw.TextStyle(
                                fontSize: 7.5,
                                color: PdfColors.blue100,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ── MAIN
            pw.Expanded(
              child: pw.Container(
                color: white,
                padding: const pw.EdgeInsets.fromLTRB(18, 20, 16, 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (p.bio?.isNotEmpty == true) ...[
                      _mainTitle('ABOUT ME', blue),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        p.bio!,
                        style: pw.TextStyle(
                          fontSize: 8.5,
                          color: grey,
                          lineSpacing: 1.5,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                    ],
                    if (ex.isNotEmpty) ...[
                      _mainTitle('EXPERIENCE', blue),
                      ...ex.map(
                        (e) => _timelineEntry(
                          e.jobTitle,
                          '${e.companyName} | ${e.duration}',
                          e.description,
                          blue,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (ed.isNotEmpty) ...[
                      _mainTitle('EDUCATION', blue),
                      ...ed.map(
                        (e) => _timelineEntry(
                          e.degree,
                          '${e.institution} | ${e.duration}',
                          e.description ?? '',
                          blue,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (pr.isNotEmpty) ...[
                      _mainTitle('PROJECTS', blue),
                      ...pr.map(
                        (p2) => _timelineEntry(
                          p2.name,
                          p2.technologies,
                          p2.description,
                          blue,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (ac.isNotEmpty) ...[
                      _mainTitle('ACHIEVEMENTS', blue),
                      ...ac.map(
                        (a) => _timelineEntry(
                          a.title,
                          a.date ?? '',
                          a.description,
                          blue,
                          grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T2 – Dark Red Hero
  //  Layout: Full-page dark bg, red accent, wide top hero, 2-col body
  //  Style : Bold dark professional
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t2DarkRedHero(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const bg = PdfColor.fromInt(0xFF1A1A2E);
    const card = PdfColor.fromInt(0xFF16213E);
    const red = PdfColor.fromInt(0xFFE94560);
    const white = PdfColors.white;
    const light = PdfColor.fromInt(0xFFCCCCCC);
    const mid = PdfColor.fromInt(0xFF888888);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // HERO
            pw.Container(
              color: bg,
              padding: const pw.EdgeInsets.fromLTRB(26, 22, 26, 18),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  _circleAvatar(
                    img,
                    76,
                    red,
                    PdfColors.red200,
                    p,
                    borderColor: red,
                    borderWidth: 3,
                  ),
                  pw.SizedBox(width: 16),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                            letterSpacing: 1,
                          ),
                        ),
                        pw.Container(
                          margin: const pw.EdgeInsets.symmetric(vertical: 4),
                          width: 36,
                          height: 2,
                          color: red,
                        ),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(fontSize: 10, color: red),
                        ),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (p.email?.isNotEmpty == true)
                        pw.Text(
                          p.email!,
                          style: pw.TextStyle(fontSize: 8, color: light),
                        ),
                      if (p.phoneNumber?.isNotEmpty == true)
                        pw.Text(
                          p.phoneNumber!,
                          style: pw.TextStyle(fontSize: 8, color: light),
                        ),
                      if (p.address?.isNotEmpty == true)
                        pw.Text(
                          p.address!,
                          style: pw.TextStyle(fontSize: 8, color: mid),
                        ),
                      if (p.linkedin?.isNotEmpty == true)
                        pw.Text(
                          p.linkedin!,
                          style: pw.TextStyle(fontSize: 8, color: red),
                        ),
                      if (p.github?.isNotEmpty == true)
                        pw.Text(
                          p.github!,
                          style: pw.TextStyle(fontSize: 8, color: red),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            pw.Container(height: 2, color: red),
            // BODY 2-COL
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  pw.Container(
                    width: 188,
                    color: bg,
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _darkTitle('PROFILE', red),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 7.8,
                              color: light,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 11),
                        ],
                        if (sk.isNotEmpty) ...[
                          _darkTitle('SKILLS', red),
                          ...sk.map(
                            (s) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 3),
                              child: pw.Row(
                                children: [
                                  pw.Container(width: 4, height: 4, color: red),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    s.name,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      color: light,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 11),
                        ],
                        if (ed.isNotEmpty) ...[
                          _darkTitle('EDUCATION', red),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 7),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: pw.FontWeight.bold,
                                      color: white,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: red,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: mid,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 11),
                        ],
                        if (ho.isNotEmpty) ...[
                          _darkTitle('INTERESTS', red),
                          pw.Text(
                            ho.map((h) => h.name).join('  ·  '),
                            style: pw.TextStyle(fontSize: 7.8, color: mid),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT
                  pw.Expanded(
                    child: pw.Container(
                      color: card,
                      padding: const pw.EdgeInsets.all(15),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _darkTitle('EXPERIENCE', red),
                            ...ex.map(
                              (e) => _darkCard(
                                e.jobTitle,
                                '${e.companyName} | ${e.duration}',
                                e.description,
                                red,
                                light,
                                mid,
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (pr.isNotEmpty) ...[
                            _darkTitle('PROJECTS', red),
                            ...pr.map(
                              (p2) => _darkCard(
                                p2.name,
                                p2.technologies,
                                p2.description,
                                red,
                                light,
                                mid,
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (ac.isNotEmpty) ...[
                            _darkTitle('ACHIEVEMENTS', red),
                            ...ac.map(
                              (a) => _darkCard(
                                a.title,
                                a.date ?? '',
                                a.description,
                                red,
                                light,
                                mid,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T3 – Pure Black & White Minimalist
  //  Layout: 2-col, typography-only, zero color
  //  Style : B&W editorial
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t3BWMinimalist(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const black = PdfColors.black;
    const grey = PdfColor.fromInt(0xFF555555);
    const lgrey = PdfColor.fromInt(0xFFBBBBBB);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(36, 30, 36, 26),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // HEADER
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        (p.fullName ?? 'YOUR NAME').toUpperCase(),
                        style: pw.TextStyle(
                          fontSize: 26,
                          fontWeight: pw.FontWeight.bold,
                          color: black,
                          letterSpacing: 4,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        p.professionalTitle ?? '',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: grey,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                if (img != null)
                  pw.Container(
                    width: 62,
                    height: 62,
                    child: pw.ClipOval(
                      child: pw.Image(
                        pw.MemoryImage(img),
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Container(height: 2, color: black),
            pw.SizedBox(height: 3),
            pw.Row(
              children: [
                if (p.email?.isNotEmpty == true)
                  pw.Text(
                    p.email!,
                    style: pw.TextStyle(fontSize: 7.5, color: grey),
                  ),
                if (p.phoneNumber?.isNotEmpty == true) ...[
                  _dot(grey),
                  pw.Text(
                    p.phoneNumber!,
                    style: pw.TextStyle(fontSize: 7.5, color: grey),
                  ),
                ],
                if (p.address?.isNotEmpty == true) ...[
                  _dot(grey),
                  pw.Text(
                    p.address!,
                    style: pw.TextStyle(fontSize: 7.5, color: grey),
                  ),
                ],
                if (p.linkedin?.isNotEmpty == true) ...[
                  _dot(grey),
                  pw.Text(
                    p.linkedin!,
                    style: pw.TextStyle(fontSize: 7.5, color: grey),
                  ),
                ],
              ],
            ),
            pw.Container(
              height: 0.5,
              color: lgrey,
              margin: const pw.EdgeInsets.only(top: 3),
            ),
            pw.SizedBox(height: 12),
            // 2-COL BODY
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // LEFT 60%
                  pw.Expanded(
                    flex: 60,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _bwSec('SUMMARY', black, lgrey),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 8.5,
                              color: grey,
                              lineSpacing: 1.5,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ex.isNotEmpty) ...[
                          _bwSec('WORK EXPERIENCE', black, lgrey),
                          ...ex.map(
                            (e) => _bwEntry(
                              e.jobTitle,
                              '${e.companyName}  ·  ${e.duration}',
                              e.description,
                              black,
                              grey,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (pr.isNotEmpty) ...[
                          _bwSec('PROJECTS', black, lgrey),
                          ...pr.map(
                            (p2) => _bwEntry(
                              p2.name,
                              p2.technologies,
                              p2.description,
                              black,
                              grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 14),
                  pw.Container(width: 0.5, color: lgrey),
                  pw.SizedBox(width: 14),
                  // RIGHT 40%
                  pw.Expanded(
                    flex: 40,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (sk.isNotEmpty) ...[
                          _bwSec('SKILLS', black, lgrey),
                          pw.Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: sk
                                .map(
                                  (s) => pw.Container(
                                    padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: black,
                                        width: 0.6,
                                      ),
                                    ),
                                    child: pw.Text(
                                      s.name,
                                      style: pw.TextStyle(
                                        fontSize: 7.5,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ed.isNotEmpty) ...[
                          _bwSec('EDUCATION', black, lgrey),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 6),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                      color: black,
                                    ),
                                  ),
                                  pw.Text(
                                    '${e.institution}  ·  ${e.duration}',
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ac.isNotEmpty) ...[
                          _bwSec('ACHIEVEMENTS', black, lgrey),
                          ...ac.map(
                            (a) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 5),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    a.title,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: pw.FontWeight.bold,
                                      color: black,
                                    ),
                                  ),
                                  pw.Text(
                                    a.description,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: grey,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ho.isNotEmpty) ...[
                          _bwSec('INTERESTS', black, lgrey),
                          pw.Text(
                            ho.map((h) => h.name).join('  ·  '),
                            style: pw.TextStyle(fontSize: 7.5, color: grey),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T4 – Green Top Bar Full Page
  //  Layout: Full-width green banner top, 2-col body below
  //  Style : Fresh green professional
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t4GreenTopBar(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const green = PdfColor.fromInt(0xFF2E7D32);
    const gLight = PdfColor.fromInt(0xFFE8F5E9);
    const gMid = PdfColor.fromInt(0xFF4CAF50);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF1B1B1B);
    const grey = PdfColor.fromInt(0xFF666666);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // FULL-WIDTH TOP BAR
            pw.Container(
              color: green,
              padding: const pw.EdgeInsets.fromLTRB(26, 20, 26, 20),
              child: pw.Row(
                children: [
                  _circleAvatar(
                    img,
                    76,
                    gMid,
                    PdfColors.green300,
                    p,
                    borderColor: white,
                    borderWidth: 3,
                  ),
                  pw.SizedBox(width: 16),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                          ),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.green100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (p.email?.isNotEmpty == true)
                        _contactChip(p.email!, white),
                      if (p.phoneNumber?.isNotEmpty == true)
                        _contactChip(p.phoneNumber!, white),
                      if (p.address?.isNotEmpty == true)
                        _contactChip(p.address!, PdfColors.green100),
                      if (p.linkedin?.isNotEmpty == true)
                        _contactChip(p.linkedin!, PdfColors.green100),
                    ],
                  ),
                ],
              ),
            ),
            // 2-COL BODY
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT light green
                  pw.Container(
                    width: 176,
                    color: gLight,
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _greenTitle('ABOUT', green),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 8,
                              color: grey,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (sk.isNotEmpty) ...[
                          _greenTitle('SKILLS', green),
                          pw.Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: sk
                                .map(
                                  (s) => pw.Container(
                                    padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 3,
                                    ),
                                    decoration: pw.BoxDecoration(
                                      color: green,
                                      borderRadius: pw.BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: pw.Text(
                                      s.name,
                                      style: pw.TextStyle(
                                        fontSize: 7.5,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ed.isNotEmpty) ...[
                          _greenTitle('EDUCATION', green),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 7),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                      color: dark,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: green,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ho.isNotEmpty) ...[
                          _greenTitle('HOBBIES', green),
                          ...ho.map(
                            (h) => pw.Text(
                              '· ${h.name}',
                              style: pw.TextStyle(fontSize: 8, color: grey),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT white
                  pw.Expanded(
                    child: pw.Container(
                      color: white,
                      padding: const pw.EdgeInsets.fromLTRB(16, 14, 14, 12),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _greenTitle('EXPERIENCE', green),
                            ...ex.map(
                              (e) => _greenEntry(
                                e.jobTitle,
                                '${e.companyName} | ${e.duration}',
                                e.description,
                                green,
                                grey,
                                dark,
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (pr.isNotEmpty) ...[
                            _greenTitle('PROJECTS', green),
                            ...pr.map(
                              (p2) => _greenEntry(
                                p2.name,
                                p2.technologies,
                                p2.description,
                                green,
                                grey,
                                dark,
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (ac.isNotEmpty) ...[
                            _greenTitle('ACHIEVEMENTS', green),
                            ...ac.map(
                              (a) => _greenEntry(
                                a.title,
                                a.date ?? '',
                                a.description,
                                green,
                                grey,
                                dark,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T5 – Teal Cards
  //  Layout: Teal header + 2-col body with card-boxed entries
  //  Style : Modern card-based
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t5TealCards(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const teal = PdfColor.fromInt(0xFF00695C);
    const tLite = PdfColor.fromInt(0xFFE0F2F1);
    const tAcc = PdfColor.fromInt(0xFF26A69A);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF212121);
    const grey = PdfColor.fromInt(0xFF757575);
    const bgGr = PdfColor.fromInt(0xFFF5F5F5);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // HEADER
            pw.Container(
              color: teal,
              padding: const pw.EdgeInsets.fromLTRB(24, 22, 24, 18),
              child: pw.Column(
                children: [
                  pw.Row(
                    children: [
                      _circleAvatar(
                        img,
                        78,
                        tAcc,
                        PdfColors.teal300,
                        p,
                        borderColor: tLite,
                        borderWidth: 3,
                      ),
                      pw.SizedBox(width: 14),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              p.fullName ?? 'Your Name',
                              style: pw.TextStyle(
                                fontSize: 21,
                                fontWeight: pw.FontWeight.bold,
                                color: white,
                              ),
                            ),
                            pw.SizedBox(height: 4),
                            pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: pw.BoxDecoration(
                                color: tAcc,
                                borderRadius: pw.BorderRadius.circular(12),
                              ),
                              child: pw.Text(
                                p.professionalTitle ?? '',
                                style: pw.TextStyle(
                                  fontSize: 8.5,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: [
                      if (p.email?.isNotEmpty == true)
                        _pChip(p.email!, tAcc, white),
                      if (p.phoneNumber?.isNotEmpty == true)
                        _pChip(p.phoneNumber!, tAcc, white),
                      if (p.address?.isNotEmpty == true)
                        _pChip(p.address!, tAcc, white),
                      if (p.linkedin?.isNotEmpty == true)
                        _pChip(p.linkedin!, tAcc, white),
                      if (p.github?.isNotEmpty == true)
                        _pChip(p.github!, tAcc, white),
                    ],
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT teal-lite
                  pw.Container(
                    width: 183,
                    color: tLite,
                    padding: const pw.EdgeInsets.all(13),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _tealSecTitle('PROFILE', teal),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 7.8,
                              color: grey,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 9),
                        ],
                        if (sk.isNotEmpty) ...[
                          _tealSecTitle('SKILLS', teal),
                          ...sk.map(
                            (s) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 3),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 5,
                                    height: 5,
                                    decoration: pw.BoxDecoration(
                                      color: teal,
                                      shape: pw.BoxShape.circle,
                                    ),
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    s.name,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      color: dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 9),
                        ],
                        if (ed.isNotEmpty) ...[
                          _tealSecTitle('EDUCATION', teal),
                          ...ed.map(
                            (e) => pw.Container(
                              margin: const pw.EdgeInsets.only(bottom: 6),
                              padding: const pw.EdgeInsets.all(7),
                              decoration: pw.BoxDecoration(
                                color: white,
                                borderRadius: pw.BorderRadius.circular(5),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: pw.FontWeight.bold,
                                      color: dark,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: teal,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 9),
                        ],
                        if (ho.isNotEmpty) ...[
                          _tealSecTitle('HOBBIES', teal),
                          pw.Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: ho
                                .map(
                                  (h) => pw.Container(
                                    padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: pw.BoxDecoration(
                                      color: teal,
                                      borderRadius: pw.BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    child: pw.Text(
                                      h.name,
                                      style: pw.TextStyle(
                                        fontSize: 7.5,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT bgGrey
                  pw.Expanded(
                    child: pw.Container(
                      color: bgGr,
                      padding: const pw.EdgeInsets.all(13),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _tealSecTitle('EXPERIENCE', teal),
                            ...ex.map(
                              (e) => _tealCard(
                                e.jobTitle,
                                '${e.companyName} | ${e.duration}',
                                e.description,
                                teal,
                                grey,
                                dark,
                                white,
                                tAcc,
                              ),
                            ),
                            pw.SizedBox(height: 7),
                          ],
                          if (pr.isNotEmpty) ...[
                            _tealSecTitle('PROJECTS', teal),
                            ...pr.map(
                              (p2) => _tealCard(
                                p2.name,
                                p2.technologies,
                                p2.description,
                                teal,
                                grey,
                                dark,
                                white,
                                tAcc,
                              ),
                            ),
                            pw.SizedBox(height: 7),
                          ],
                          if (ac.isNotEmpty) ...[
                            _tealSecTitle('ACHIEVEMENTS', teal),
                            ...ac.map(
                              (a) => _tealCard(
                                a.title,
                                a.date ?? '',
                                a.description,
                                teal,
                                grey,
                                dark,
                                white,
                                tAcc,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T6 – Purple Timeline
  //  Layout: Purple left bar, timeline dots on right
  //  Style : Creative timeline
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t6PurpleTimeline(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const purp = PdfColor.fromInt(0xFF6A1B9A);
    const pLite = PdfColor.fromInt(0xFFF3E5F5);
    const pAcc = PdfColor.fromInt(0xFFAB47BC);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF1A1A1A);
    const grey = PdfColor.fromInt(0xFF666666);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // LEFT SIDEBAR
            pw.Container(
              width: 180,
              color: purp,
              child: pw.Column(
                children: [
                  // Photo block
                  pw.Container(
                    width: double.infinity,
                    color: PdfColor.fromInt(0xFF4A148C),
                    padding: const pw.EdgeInsets.fromLTRB(14, 22, 14, 18),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _circleAvatar(
                          img,
                          68,
                          pAcc,
                          PdfColors.purple200,
                          p,
                          borderColor: white,
                          borderWidth: 2,
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(
                            fontSize: 7.5,
                            color: PdfColors.purple100,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(13),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _sbTitle('CONTACT', white, PdfColors.purple200),
                          if (p.email?.isNotEmpty == true)
                            _sbItem('✉ ${p.email}', white),
                          if (p.phoneNumber?.isNotEmpty == true)
                            _sbItem('☎ ${p.phoneNumber}', white),
                          if (p.address?.isNotEmpty == true)
                            _sbItem('⌂ ${p.address}', white),
                          if (p.linkedin?.isNotEmpty == true)
                            _sbItem('in ${p.linkedin}', white),
                          if (p.github?.isNotEmpty == true)
                            _sbItem('⊕ ${p.github}', white),
                          pw.SizedBox(height: 11),
                          if (sk.isNotEmpty) ...[
                            _sbTitle('SKILLS', white, PdfColors.purple200),
                            ...sk.map(
                              (s) =>
                                  _sbBullet(s.name, white, PdfColors.purple100),
                            ),
                            pw.SizedBox(height: 11),
                          ],
                          if (ho.isNotEmpty) ...[
                            _sbTitle('HOBBIES', white, PdfColors.purple200),
                            pw.Text(
                              ho.map((h) => h.name).join(' · '),
                              style: pw.TextStyle(
                                fontSize: 7.5,
                                color: PdfColors.purple100,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // RIGHT: timeline layout
            pw.Expanded(
              child: pw.Container(
                color: white,
                padding: const pw.EdgeInsets.fromLTRB(18, 20, 16, 14),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (p.bio?.isNotEmpty == true) ...[
                      _purpleTitle('ABOUT ME', purp, pLite),
                      pw.Text(
                        p.bio!,
                        style: pw.TextStyle(
                          fontSize: 8.5,
                          color: grey,
                          lineSpacing: 1.4,
                        ),
                      ),
                      pw.SizedBox(height: 11),
                    ],
                    if (ex.isNotEmpty) ...[
                      _purpleTitle('EXPERIENCE', purp, pLite),
                      ...ex.map(
                        (e) => _timelineDot(
                          e.jobTitle,
                          '${e.companyName} | ${e.duration}',
                          e.description,
                          purp,
                          pAcc,
                          grey,
                          dark,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (ed.isNotEmpty) ...[
                      _purpleTitle('EDUCATION', purp, pLite),
                      ...ed.map(
                        (e) => _timelineDot(
                          e.degree,
                          '${e.institution} | ${e.duration}',
                          e.description ?? '',
                          purp,
                          pAcc,
                          grey,
                          dark,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (pr.isNotEmpty) ...[
                      _purpleTitle('PROJECTS', purp, pLite),
                      ...pr.map(
                        (p2) => _timelineDot(
                          p2.name,
                          p2.technologies,
                          p2.description,
                          purp,
                          pAcc,
                          grey,
                          dark,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T7 – Orange Infographic
  //  Layout: Full-page orange top, skill bars, 2-col
  //  Style : Infographic / bold
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t7OrangeInfographic(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const org = PdfColor.fromInt(0xFFE65100);
    const oLite = PdfColor.fromInt(0xFFFFF3E0);
    const oAcc = PdfColor.fromInt(0xFFFF9800);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF1C1C1C);
    const grey = PdfColor.fromInt(0xFF666666);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // HEADER
            pw.Container(
              color: org,
              padding: const pw.EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: pw.Row(
                children: [
                  _circleAvatar(
                    img,
                    72,
                    oAcc,
                    PdfColors.orange200,
                    p,
                    borderColor: white,
                    borderWidth: 3,
                  ),
                  pw.SizedBox(width: 16),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 22,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Container(width: 40, height: 2, color: oAcc),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.orange100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      if (p.email?.isNotEmpty == true)
                        pw.Text(
                          p.email!,
                          style: pw.TextStyle(fontSize: 7.5, color: white),
                        ),
                      if (p.phoneNumber?.isNotEmpty == true)
                        pw.Text(
                          p.phoneNumber!,
                          style: pw.TextStyle(fontSize: 7.5, color: white),
                        ),
                      if (p.address?.isNotEmpty == true)
                        pw.Text(
                          p.address!,
                          style: pw.TextStyle(
                            fontSize: 7.5,
                            color: PdfColors.orange100,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            pw.Container(height: 3, color: oAcc),
            // BODY
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  pw.Container(
                    width: 180,
                    color: oLite,
                    padding: const pw.EdgeInsets.all(14),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _orgTitle('PROFILE', org),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 7.8,
                              color: grey,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (sk.isNotEmpty) ...[
                          _orgTitle('SKILLS', org),
                          ...sk
                              .take(8)
                              .map(
                                (s) => pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 5),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      // Skill name
                                      pw.Text(
                                        s.name,
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          color: dark,
                                        ),
                                      ),
                                      pw.SizedBox(height: 2),

                                      // Skill bar
                                      pw.LayoutBuilder(
                                        builder: (context, constraints) {
                                          return pw.Container(
                                            height: 5,
                                            decoration: pw.BoxDecoration(
                                              color: PdfColors.grey300,
                                              borderRadius:
                                                  pw.BorderRadius.circular(3),
                                            ),
                                            child: pw.Container(
                                              width:
                                                  constraints!.maxWidth *
                                                  0.75, // 75% width
                                              decoration: pw.BoxDecoration(
                                                color: org,
                                                borderRadius:
                                                    pw.BorderRadius.circular(3),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ed.isNotEmpty) ...[
                          _orgTitle('EDUCATION', org),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 7),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: pw.FontWeight.bold,
                                      color: dark,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: org,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (ho.isNotEmpty) ...[
                          pw.SizedBox(height: 10),
                          _orgTitle('INTERESTS', org),
                          pw.Text(
                            ho.map((h) => h.name).join('  ·  '),
                            style: pw.TextStyle(fontSize: 7.5, color: grey),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT
                  pw.Expanded(
                    child: pw.Container(
                      color: white,
                      padding: const pw.EdgeInsets.all(14),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _orgTitle('EXPERIENCE', org),
                            ...ex.map(
                              (e) => pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                padding: const pw.EdgeInsets.all(8),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                    left: pw.BorderSide(color: org, width: 3),
                                  ),
                                  color: oLite,
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      e.jobTitle,
                                      style: pw.TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: pw.FontWeight.bold,
                                        color: dark,
                                      ),
                                    ),
                                    pw.Text(
                                      '${e.companyName} | ${e.duration}',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                        color: org,
                                      ),
                                    ),
                                    if (e.description.isNotEmpty)
                                      pw.Text(
                                        e.description,
                                        style: pw.TextStyle(
                                          fontSize: 7.8,
                                          color: grey,
                                        ),
                                        maxLines: 2,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 8),
                          ],
                          if (pr.isNotEmpty) ...[
                            _orgTitle('PROJECTS', org),
                            ...pr.map(
                              (p2) => pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                padding: const pw.EdgeInsets.all(8),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                    left: pw.BorderSide(color: oAcc, width: 3),
                                  ),
                                  color: oLite,
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      p2.name,
                                      style: pw.TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: pw.FontWeight.bold,
                                        color: dark,
                                      ),
                                    ),
                                    pw.Text(
                                      p2.technologies,
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                        color: oAcc,
                                      ),
                                    ),
                                    if (p2.description.isNotEmpty)
                                      pw.Text(
                                        p2.description,
                                        style: pw.TextStyle(
                                          fontSize: 7.8,
                                          color: grey,
                                        ),
                                        maxLines: 2,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          if (ac.isNotEmpty) ...[
                            _orgTitle('ACHIEVEMENTS', org),
                            ...ac.map(
                              (a) => pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 6),
                                child: pw.Row(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(top: 3),
                                      width: 6,
                                      height: 6,
                                      decoration: pw.BoxDecoration(
                                        color: org,
                                        shape: pw.BoxShape.circle,
                                      ),
                                    ),
                                    pw.SizedBox(width: 6),
                                    pw.Expanded(
                                      child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            a.title,
                                            style: pw.TextStyle(
                                              fontSize: 9,
                                              fontWeight: pw.FontWeight.bold,
                                              color: dark,
                                            ),
                                          ),
                                          pw.Text(
                                            a.description,
                                            style: pw.TextStyle(
                                              fontSize: 7.8,
                                              color: grey,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T8 – B&W Elegant  (black sidebar, white right)
  //  Layout: Thick black left sidebar, white right
  //  Style : Monochrome elegant
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t8BWElegant(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const black = PdfColors.black;
    const white = PdfColors.white;
    const grey = PdfColor.fromInt(0xFF555555);
    const lgrey = PdfColor.fromInt(0xFFDDDDDD);
    const mgrey = PdfColor.fromInt(0xFF999999);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // BLACK SIDEBAR
            pw.Container(
              width: 170,
              color: black,
              child: pw.Column(
                children: [
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.fromLTRB(14, 24, 14, 18),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        if (img != null)
                          pw.Container(
                            width: 70,
                            height: 70,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: white, width: 2),
                            ),
                            child: pw.ClipOval(
                              child: pw.Image(
                                pw.MemoryImage(img),
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          pw.Container(
                            width: 70,
                            height: 70,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              border: pw.Border.all(color: white, width: 2),
                              color: grey,
                            ),
                          ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          p.fullName ?? 'Your Name',
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          p.professionalTitle ?? '',
                          style: pw.TextStyle(fontSize: 8, color: mgrey),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Container(height: 0.5, color: mgrey),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(14, 4, 14, 14),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _sbTitle('CONTACT', white, mgrey),
                          if (p.email?.isNotEmpty == true)
                            _sbItem(p.email!, mgrey),
                          if (p.phoneNumber?.isNotEmpty == true)
                            _sbItem(p.phoneNumber!, mgrey),
                          if (p.address?.isNotEmpty == true)
                            _sbItem(p.address!, mgrey),
                          if (p.linkedin?.isNotEmpty == true)
                            _sbItem(p.linkedin!, mgrey),
                          if (p.github?.isNotEmpty == true)
                            _sbItem(p.github!, mgrey),
                          pw.SizedBox(height: 11),
                          if (sk.isNotEmpty) ...[
                            _sbTitle('SKILLS', white, mgrey),
                            ...sk.map(
                              (s) => pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 3),
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      width: 3,
                                      height: 3,
                                      color: white,
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      s.name,
                                      style: pw.TextStyle(
                                        fontSize: 8.5,
                                        color: mgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 11),
                          ],
                          if (ho.isNotEmpty) ...[
                            _sbTitle('INTERESTS', white, mgrey),
                            pw.Text(
                              ho.map((h) => h.name).join(' · '),
                              style: pw.TextStyle(fontSize: 7.5, color: mgrey),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // WHITE MAIN
            pw.Expanded(
              child: pw.Container(
                color: white,
                padding: const pw.EdgeInsets.fromLTRB(18, 20, 16, 14),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (p.bio?.isNotEmpty == true) ...[
                      _bwMainTitle('ABOUT', black, lgrey),
                      pw.Text(
                        p.bio!,
                        style: pw.TextStyle(
                          fontSize: 8.5,
                          color: grey,
                          lineSpacing: 1.4,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                    ],
                    if (ex.isNotEmpty) ...[
                      _bwMainTitle('EXPERIENCE', black, lgrey),
                      ...ex.map(
                        (e) => _bwMainEntry(
                          e.jobTitle,
                          '${e.companyName} | ${e.duration}',
                          e.description,
                          black,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (ed.isNotEmpty) ...[
                      _bwMainTitle('EDUCATION', black, lgrey),
                      ...ed.map(
                        (e) => _bwMainEntry(
                          e.degree,
                          '${e.institution} | ${e.duration}',
                          e.description ?? '',
                          black,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (pr.isNotEmpty) ...[
                      _bwMainTitle('PROJECTS', black, lgrey),
                      ...pr.map(
                        (p2) => _bwMainEntry(
                          p2.name,
                          p2.technologies,
                          p2.description,
                          black,
                          grey,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                    ],
                    if (ac.isNotEmpty) ...[
                      _bwMainTitle('ACHIEVEMENTS', black, lgrey),
                      ...ac.map(
                        (a) => _bwMainEntry(
                          a.title,
                          a.date ?? '',
                          a.description,
                          black,
                          grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T9 – Navy & Gold Luxury
  //  Layout: Full-page, gold accents on navy, 2-col body
  //  Style : Executive luxury
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t9NavyGold(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const navy = PdfColor.fromInt(0xFF0D1B2A);
    const nCard = PdfColor.fromInt(0xFF1B2838);
    const gold = PdfColor.fromInt(0xFFD4AF37);
    const white = PdfColors.white;
    const light = PdfColor.fromInt(0xFFDDDDDD);
    const mid = PdfColor.fromInt(0xFF888888);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // FULL-WIDTH HERO
            pw.Container(
              color: navy,
              padding: const pw.EdgeInsets.fromLTRB(28, 26, 28, 20),
              child: pw.Column(
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      _circleAvatar(
                        img,
                        78,
                        PdfColor.fromInt(0xFF2C3E50),
                        PdfColors.grey400,
                        p,
                        borderColor: gold,
                        borderWidth: 3,
                      ),
                      pw.SizedBox(width: 18),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              p.fullName ?? 'Your Name',
                              style: pw.TextStyle(
                                fontSize: 24,
                                fontWeight: pw.FontWeight.bold,
                                color: white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Container(width: 50, height: 1.5, color: gold),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              p.professionalTitle ?? '',
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: gold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 12),
                  pw.Container(
                    height: 0.5,
                    color: PdfColor.fromInt(0xFF333333),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (p.email?.isNotEmpty == true)
                        _goldChip(p.email!, gold, navy),
                      if (p.phoneNumber?.isNotEmpty == true)
                        _goldChip(p.phoneNumber!, gold, navy),
                      if (p.address?.isNotEmpty == true)
                        _goldChip(p.address!, gold, navy),
                      if (p.linkedin?.isNotEmpty == true)
                        _goldChip(p.linkedin!, gold, navy),
                    ],
                  ),
                ],
              ),
            ),
            pw.Container(height: 2, color: gold),
            // BODY
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  pw.Container(
                    width: 185,
                    color: nCard,
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _goldTitle('PROFILE', gold),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 7.8,
                              color: light,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 11),
                        ],
                        if (sk.isNotEmpty) ...[
                          _goldTitle('EXPERTISE', gold),
                          ...sk.map(
                            (s) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 3),
                              child: pw.Row(
                                children: [
                                  pw.Container(
                                    width: 4,
                                    height: 4,
                                    color: gold,
                                  ),
                                  pw.SizedBox(width: 6),
                                  pw.Text(
                                    s.name,
                                    style: pw.TextStyle(
                                      fontSize: 8.5,
                                      color: light,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 11),
                        ],
                        if (ed.isNotEmpty) ...[
                          _goldTitle('EDUCATION', gold),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 7),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                      color: white,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: gold,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: mid,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (ho.isNotEmpty) ...[
                          pw.SizedBox(height: 11),
                          _goldTitle('INTERESTS', gold),
                          pw.Text(
                            ho.map((h) => h.name).join('  ·  '),
                            style: pw.TextStyle(fontSize: 7.5, color: mid),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT
                  pw.Expanded(
                    child: pw.Container(
                      color: navy,
                      padding: const pw.EdgeInsets.all(15),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _goldTitle('EXPERIENCE', gold),
                            ...ex.map(
                              (e) => pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                    left: pw.BorderSide(color: gold, width: 2),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.fromLTRB(
                                  8,
                                  4,
                                  4,
                                  4,
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      e.jobTitle,
                                      style: pw.TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: pw.FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    pw.Text(
                                      '${e.companyName} | ${e.duration}',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                        color: gold,
                                      ),
                                    ),
                                    if (e.description.isNotEmpty)
                                      pw.Text(
                                        e.description,
                                        style: pw.TextStyle(
                                          fontSize: 7.8,
                                          color: light,
                                        ),
                                        maxLines: 2,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (pr.isNotEmpty) ...[
                            _goldTitle('PROJECTS', gold),
                            ...pr.map(
                              (p2) => pw.Container(
                                margin: const pw.EdgeInsets.only(bottom: 8),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                    left: pw.BorderSide(color: gold, width: 2),
                                  ),
                                ),
                                padding: const pw.EdgeInsets.fromLTRB(
                                  8,
                                  4,
                                  4,
                                  4,
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      p2.name,
                                      style: pw.TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: pw.FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    pw.Text(
                                      p2.technologies,
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                        color: gold,
                                      ),
                                    ),
                                    if (p2.description.isNotEmpty)
                                      pw.Text(
                                        p2.description,
                                        style: pw.TextStyle(
                                          fontSize: 7.8,
                                          color: light,
                                        ),
                                        maxLines: 2,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 9),
                          ],
                          if (ac.isNotEmpty) ...[
                            _goldTitle('ACHIEVEMENTS', gold),
                            ...ac.map(
                              (a) => pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 6),
                                child: pw.Row(
                                  children: [
                                    pw.Container(
                                      width: 5,
                                      height: 5,
                                      decoration: pw.BoxDecoration(
                                        color: gold,
                                        shape: pw.BoxShape.circle,
                                      ),
                                    ),
                                    pw.SizedBox(width: 6),
                                    pw.Expanded(
                                      child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            a.title,
                                            style: pw.TextStyle(
                                              fontSize: 9,
                                              fontWeight: pw.FontWeight.bold,
                                              color: white,
                                            ),
                                          ),
                                          pw.Text(
                                            a.description,
                                            style: pw.TextStyle(
                                              fontSize: 7.8,
                                              color: light,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ═══════════════════════════════════════════════════════════════════
  //  T10 – Red Bold Modern
  //  Layout: Big red name bar top, full-page 2-col, bold typography
  //  Style : Bold modern red
  // ═══════════════════════════════════════════════════════════════════
  static pw.Document _t10RedBoldModern(
    ProfileModel p,
    List<SkillModel> sk,
    List<ExperienceModel> ex,
    List<EducationModel> ed,
    List<ProjectModel> pr,
    List<AchievementModel> ac,
    List<HobbyModel> ho,
    Uint8List? img,
  ) {
    const red = PdfColor.fromInt(0xFFC62828);
    const rDark = PdfColor.fromInt(0xFF7F0000);
    const rLite = PdfColor.fromInt(0xFFFFEBEE);
    const white = PdfColors.white;
    const dark = PdfColor.fromInt(0xFF1A1A1A);
    const grey = PdfColor.fromInt(0xFF555555);
    const lgrey = PdfColor.fromInt(0xFFF0F0F0);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            // TOP: big bold name bar
            pw.Container(
              color: red,
              padding: const pw.EdgeInsets.fromLTRB(26, 22, 26, 16),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          (p.fullName ?? 'Your Name').toUpperCase(),
                          style: pw.TextStyle(
                            fontSize: 26,
                            fontWeight: pw.FontWeight.bold,
                            color: white,
                            letterSpacing: 2,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Row(
                          children: [
                            pw.Container(width: 3, height: 16, color: white),
                            pw.SizedBox(width: 6),
                            pw.Text(
                              p.professionalTitle ?? '',
                              style: pw.TextStyle(
                                fontSize: 11,
                                color: PdfColors.red100,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (img != null)
                    pw.Container(
                      width: 72,
                      height: 72,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        border: pw.Border.all(color: white, width: 3),
                      ),
                      child: pw.ClipOval(
                        child: pw.Image(
                          pw.MemoryImage(img),
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // CONTACT STRIP
            pw.Container(
              color: rDark,
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 6,
              ),
              child: pw.Row(
                children: [
                  if (p.email?.isNotEmpty == true) _strip(p.email!, white),
                  if (p.phoneNumber?.isNotEmpty == true) ...[
                    _stripDot(white),
                    _strip(p.phoneNumber!, white),
                  ],
                  if (p.address?.isNotEmpty == true) ...[
                    _stripDot(white),
                    _strip(p.address!, white),
                  ],
                  if (p.linkedin?.isNotEmpty == true) ...[
                    _stripDot(white),
                    _strip(p.linkedin!, white),
                  ],
                ],
              ),
            ),
            // BODY 2-COL
            pw.Expanded(
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  pw.Container(
                    width: 178,
                    color: rLite,
                    padding: const pw.EdgeInsets.all(14),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (p.bio?.isNotEmpty == true) ...[
                          _redTitle('ABOUT ME', red),
                          pw.Text(
                            p.bio!,
                            style: pw.TextStyle(
                              fontSize: 8,
                              color: grey,
                              lineSpacing: 1.4,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (sk.isNotEmpty) ...[
                          _redTitle('SKILLS', red),
                          pw.Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: sk
                                .map(
                                  (s) => pw.Container(
                                    padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 3,
                                    ),
                                    decoration: pw.BoxDecoration(
                                      color: red,
                                      borderRadius: pw.BorderRadius.circular(4),
                                    ),
                                    child: pw.Text(
                                      s.name,
                                      style: pw.TextStyle(
                                        fontSize: 7.5,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                        if (ed.isNotEmpty) ...[
                          _redTitle('EDUCATION', red),
                          ...ed.map(
                            (e) => pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 7),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    e.degree,
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                      color: dark,
                                    ),
                                  ),
                                  pw.Text(
                                    e.institution,
                                    style: pw.TextStyle(
                                      fontSize: 7.5,
                                      color: red,
                                    ),
                                  ),
                                  pw.Text(
                                    e.duration,
                                    style: pw.TextStyle(
                                      fontSize: 7,
                                      color: grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (ho.isNotEmpty) ...[
                          pw.SizedBox(height: 10),
                          _redTitle('HOBBIES', red),
                          pw.Text(
                            ho.map((h) => h.name).join(' · '),
                            style: pw.TextStyle(fontSize: 7.5, color: grey),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // RIGHT
                  pw.Expanded(
                    child: pw.Container(
                      color: white,
                      padding: const pw.EdgeInsets.all(14),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (ex.isNotEmpty) ...[
                            _redTitle('EXPERIENCE', red),
                            ...ex.map(
                              (e) => _redEntry(
                                e.jobTitle,
                                '${e.companyName} | ${e.duration}',
                                e.description,
                                red,
                                grey,
                                dark,
                              ),
                            ),
                            pw.SizedBox(height: 8),
                          ],
                          if (pr.isNotEmpty) ...[
                            _redTitle('PROJECTS', red),
                            ...pr.map(
                              (p2) => _redEntry(
                                p2.name,
                                p2.technologies,
                                p2.description,
                                red,
                                grey,
                                dark,
                              ),
                            ),
                            pw.SizedBox(height: 8),
                          ],
                          if (ac.isNotEmpty) ...[
                            _redTitle('ACHIEVEMENTS', red),
                            ...ac.map(
                              (a) => _redEntry(
                                a.title,
                                a.date ?? '',
                                a.description,
                                red,
                                grey,
                                dark,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  // ════════════════════════════════════════════════════
  //  SHARED HELPERS
  // ════════════════════════════════════════════════════

  // Circular avatar with fallback initial
  static pw.Widget _circleAvatar(
    Uint8List? img,
    double size,
    PdfColor fallbackBg,
    PdfColor fallbackFg,
    ProfileModel p, {
    PdfColor borderColor = PdfColors.white,
    double borderWidth = 2,
  }) {
    return pw.Container(
      width: size,
      height: size,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(color: borderColor, width: borderWidth),
        color: img == null ? fallbackBg : null,
      ),
      child: img != null
          ? pw.ClipOval(
              child: pw.Image(pw.MemoryImage(img), fit: pw.BoxFit.cover),
            )
          : pw.Center(
              child: pw.Text(
                p.fullName?.substring(0, 1).toUpperCase() ?? 'A',
                style: pw.TextStyle(
                  fontSize: size * 0.35,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                ),
              ),
            ),
    );
  }

  // Sidebar heading
  static pw.Widget _sbTitle(String text, PdfColor color, PdfColor lineColor) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: color,
              letterSpacing: 1.5,
            ),
          ),
          pw.Container(
            height: 0.7,
            color: lineColor,
            margin: const pw.EdgeInsets.only(top: 2, bottom: 4),
          ),
        ],
      );
  static pw.Widget _sbItem(String text, PdfColor color) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: 7.8, color: color),
      maxLines: 1,
    ),
  );
  static pw.Widget _sbBullet(
    String text,
    PdfColor dotColor,
    PdfColor textColor,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.Row(
      children: [
        pw.Container(
          width: 4,
          height: 4,
          decoration: pw.BoxDecoration(
            color: dotColor,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.SizedBox(width: 5),
        pw.Expanded(
          child: pw.Text(
            text,
            style: pw.TextStyle(fontSize: 8, color: textColor),
          ),
        ),
      ],
    ),
  );

  // Main content section title with left bar
  static pw.Widget _mainTitle(String text, PdfColor accent) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        children: [
          pw.Container(width: 3, height: 13, color: accent),
          pw.SizedBox(width: 5),
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: accent,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
      pw.Container(
        height: 0.5,
        color: PdfColors.grey300,
        margin: const pw.EdgeInsets.only(top: 3, bottom: 5),
      ),
    ],
  );

  static pw.Widget _timelineEntry(
    String title,
    String sub,
    String desc,
    PdfColor accent,
    PdfColor grey,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 7),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
        pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: accent)),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );

  // Dark template helpers
  static pw.Widget _darkTitle(String text, PdfColor accent) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: accent,
          letterSpacing: 1.8,
        ),
      ),
      pw.Container(
        height: 1,
        color: accent,
        margin: const pw.EdgeInsets.only(top: 2, bottom: 5),
      ),
    ],
  );
  static pw.Widget _darkCard(
    String title,
    String sub,
    String desc,
    PdfColor accent,
    PdfColor light,
    PdfColor mid,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 2,
          height: 38,
          color: accent,
          margin: const pw.EdgeInsets.only(right: 7, top: 2),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 9.5,
                  fontWeight: pw.FontWeight.bold,
                  color: light,
                ),
              ),
              pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: accent)),
              if (desc.isNotEmpty)
                pw.Text(
                  desc,
                  style: pw.TextStyle(fontSize: 7.8, color: mid),
                  maxLines: 2,
                ),
            ],
          ),
        ),
      ],
    ),
  );

  // BW helpers
  static pw.Widget _bwSec(String text, PdfColor black, PdfColor lgrey) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 9.5,
              fontWeight: pw.FontWeight.bold,
              color: black,
              letterSpacing: 2,
            ),
          ),
          pw.Container(
            height: 0.7,
            color: lgrey,
            margin: const pw.EdgeInsets.only(top: 2, bottom: 5),
          ),
        ],
      );
  static pw.Widget _bwEntry(
    String title,
    String sub,
    String desc,
    PdfColor black,
    PdfColor grey,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 7),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: black,
          ),
        ),
        pw.Text(
          sub,
          style: pw.TextStyle(
            fontSize: 8,
            color: grey,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );
  static pw.Widget _dot(PdfColor c) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 5),
    child: pw.Text('·', style: pw.TextStyle(fontSize: 8, color: c)),
  );

  // Green helpers
  static pw.Widget _contactChip(String t, PdfColor c) =>
      pw.Text(t, style: pw.TextStyle(fontSize: 7.8, color: c));
  static pw.Widget _greenTitle(String text, PdfColor green) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        children: [
          pw.Container(width: 10, height: 1.5, color: green),
          pw.SizedBox(width: 4),
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 9.5,
              fontWeight: pw.FontWeight.bold,
              color: green,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      pw.Container(
        height: 0.5,
        color: PdfColors.grey300,
        margin: const pw.EdgeInsets.only(top: 3, bottom: 5),
      ),
    ],
  );
  static pw.Widget _greenEntry(
    String title,
    String sub,
    String desc,
    PdfColor green,
    PdfColor grey,
    PdfColor dark,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: dark,
          ),
        ),
        pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: green)),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );

  // Teal helpers
  static pw.Widget _pChip(String t, PdfColor bg, PdfColor fg) => pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: pw.BoxDecoration(
      color: bg,
      borderRadius: pw.BorderRadius.circular(10),
    ),
    child: pw.Text(t, style: pw.TextStyle(fontSize: 7.5, color: fg)),
  );
  static pw.Widget _tealSecTitle(String text, PdfColor teal) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 5),
    child: pw.Row(
      children: [
        pw.Container(
          width: 3,
          height: 12,
          color: teal,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(2),
          ),
        ),
        pw.SizedBox(width: 5),
        pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: teal,
            letterSpacing: 0.8,
          ),
        ),
      ],
    ),
  );
  static pw.Widget _tealCard(
    String title,
    String sub,
    String desc,
    PdfColor teal,
    PdfColor grey,
    PdfColor dark,
    PdfColor white,
    PdfColor acc,
  ) => pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 6),
    decoration: pw.BoxDecoration(
      color: white,
      borderRadius: pw.BorderRadius.circular(5),
      border: pw.Border(left: pw.BorderSide(color: teal, width: 3)),
    ),
    padding: const pw.EdgeInsets.fromLTRB(8, 6, 8, 6),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: dark,
          ),
        ),
        if (sub.isNotEmpty)
          pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: acc)),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 7.8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );

  // Purple helpers
  static pw.Widget _purpleTitle(String text, PdfColor purp, PdfColor lite) =>
      pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 5),
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        color: lite,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: purp,
            letterSpacing: 1,
          ),
        ),
      );
  static pw.Widget _timelineDot(
    String title,
    String sub,
    String desc,
    PdfColor purp,
    PdfColor pAcc,
    PdfColor grey,
    PdfColor dark,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          children: [
            pw.Container(
              width: 10,
              height: 10,
              decoration: pw.BoxDecoration(
                color: purp,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Container(width: 1.5, height: 28, color: pAcc),
          ],
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 9.5,
                  fontWeight: pw.FontWeight.bold,
                  color: dark,
                ),
              ),
              pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: purp)),
              if (desc.isNotEmpty)
                pw.Text(
                  desc,
                  style: pw.TextStyle(fontSize: 7.8, color: grey),
                  maxLines: 2,
                ),
            ],
          ),
        ),
      ],
    ),
  );

  // Orange helpers
  static pw.Widget _orgTitle(String text, PdfColor org) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9.5,
          fontWeight: pw.FontWeight.bold,
          color: org,
          letterSpacing: 1.2,
        ),
      ),
      pw.Container(
        height: 1.5,
        color: org,
        margin: const pw.EdgeInsets.only(top: 2, bottom: 5),
      ),
    ],
  );

  // B&W Elegant helpers
  static pw.Widget _bwMainTitle(String text, PdfColor black, PdfColor lgrey) =>
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(width: 14, height: 1.5, color: black),
              pw.SizedBox(width: 5),
              pw.Text(
                text,
                style: pw.TextStyle(
                  fontSize: 10.5,
                  fontWeight: pw.FontWeight.bold,
                  color: black,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          pw.Container(
            height: 0.5,
            color: lgrey,
            margin: const pw.EdgeInsets.only(top: 3, bottom: 5),
          ),
        ],
      );
  static pw.Widget _bwMainEntry(
    String title,
    String sub,
    String desc,
    PdfColor black,
    PdfColor grey,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 7),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: black,
          ),
        ),
        pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: grey)),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );

  // Gold/Navy helpers
  static pw.Widget _goldChip(String t, PdfColor gold, PdfColor bg) =>
      pw.Container(
        margin: const pw.EdgeInsets.only(right: 8),
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: gold, width: 0.8),
          borderRadius: pw.BorderRadius.circular(10),
        ),
        child: pw.Text(t, style: pw.TextStyle(fontSize: 7.5, color: gold)),
      );
  static pw.Widget _goldTitle(String text, PdfColor gold) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: pw.FontWeight.bold,
          color: gold,
          letterSpacing: 1.8,
        ),
      ),
      pw.Container(
        height: 1,
        color: gold,
        margin: const pw.EdgeInsets.only(top: 2, bottom: 5),
      ),
    ],
  );

  // Red helpers
  static pw.Widget _strip(String t, PdfColor c) =>
      pw.Text(t, style: pw.TextStyle(fontSize: 7.5, color: c));
  static pw.Widget _stripDot(PdfColor c) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 6),
    child: pw.Text('|', style: pw.TextStyle(fontSize: 7.5, color: c)),
  );
  static pw.Widget _redTitle(String text, PdfColor red) => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        children: [
          pw.Container(width: 3, height: 13, color: red),
          pw.SizedBox(width: 5),
          pw.Text(
            text,
            style: pw.TextStyle(
              fontSize: 10.5,
              fontWeight: pw.FontWeight.bold,
              color: red,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      pw.Container(
        height: 0.5,
        color: PdfColors.grey300,
        margin: const pw.EdgeInsets.only(top: 3, bottom: 5),
      ),
    ],
  );
  static pw.Widget _redEntry(
    String title,
    String sub,
    String desc,
    PdfColor red,
    PdfColor grey,
    PdfColor dark,
  ) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 9.5,
            fontWeight: pw.FontWeight.bold,
            color: dark,
          ),
        ),
        pw.Text(sub, style: pw.TextStyle(fontSize: 8, color: red)),
        if (desc.isNotEmpty)
          pw.Text(
            desc,
            style: pw.TextStyle(fontSize: 8, color: grey),
            maxLines: 2,
          ),
      ],
    ),
  );
}
