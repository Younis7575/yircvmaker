import 'package:cvmaker/views/templates/cv_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../controllers/portfolio_controller.dart';
import '../../services/appwrite_storage_service.dart';
import '../../widgets/banner_ad_widget.dart';
import '../generate_cv/generate_cv_screen.dart';
import '../downlaod/my_downloads_screen.dart';
import '../drawer/about_screen.dart';
import '../drawer/contact_screen.dart';
import '../drawer/help_screen.dart';
import '../drawer/privacy_policy_screen.dart';
import '../drawer/terms_conditions_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PortfolioController controller = Get.find<PortfolioController>();
  List files = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      final result = await AppwriteStorageService.getTemplates();
      setState(() {
        files = result;
        loading = false;
      });
    } catch (e) {
      print("Error loading templates: $e");
      setState(() => loading = false);
    }
  }

  void _openDownloadedFile(String filePath) {
    controller.openDownloadedFile(filePath);
  }

  void _showTemplatePreview(
    String imageUrl,
    String title, {
    bool isPremium = false,
  }) {
    Get.to(
      () => CvPreviewScreen(
        imageUrl: imageUrl,
        title: title,
        isPremium: isPremium,
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      /// APPBAR
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF037DF7), Color(0xFF037DF7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  /// MENU BUTTON
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// TITLE WITH SUBTITLE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "YIR CV Maker",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Professional CV Builder",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// DOWNLOADS BUTTON
                  GestureDetector(
                    onTap: () => Get.to(() => MyDownloadsScreen()),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      /// DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0048ff), Color(0xff6a11cb)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.profile?.fullName ?? "YIR CV",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Professional CV Builder",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _drawerItem(
              Icons.folder,
              "My CVs",
              () => Get.to(() => MyDownloadsScreen()),
            ),
            _drawerItem(Icons.info, "About", () => Get.to(() => AboutScreen())),
            _drawerItem(Icons.help, "Help", () => Get.to(() => HelpScreen())),
            _drawerItem(
              Icons.contact_mail,
              "Contact Us",
              () => Get.to(() => ContactUsScreen()),
            ),
            _drawerItem(
              Icons.privacy_tip,
              "Privacy Policy",
              () => Get.to(() => PrivacyPolicyScreen()),
            ),
            _drawerItem(
              Icons.description,
              "Terms & Conditions",
              () => Get.to(() => TermsConditionsScreen()),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Version 1.0", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),

      /// BODY
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  /// Banner
                  const BannerAdWidget(),
                  const SizedBox(height: 20),

                  /// Recent Downloads Section (Horizontally scrollable)
 Obx(() {
  final downloads = controller.recentDownloads;

  if (downloads.isNotEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Downloads",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.to(() => MyDownloadsScreen()),
                child: const Text(
                  "See All",
                  style: TextStyle(color: Color(0xff0048ff)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        /// Downloads list
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: downloads.length > 5 ? 5 : downloads.length,
            itemBuilder: (context, index) {
              final download = downloads[index];
              final filePath = download['filePath'] as String?;
              final file = filePath != null ? File(filePath) : null;
              final fileExists = file?.existsSync() ?? false;

              return GestureDetector(
                onTap: fileExists ? () => _openDownloadedFile(filePath!) : null,
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(blurRadius: 8, color: Colors.black12),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: _getTemplateColor(download['templateNumber']),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 50,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              download['templateName'] ?? 'CV',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    _formatDate(download['timestamp']),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (!fileExists)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'File missing',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.red[400],
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
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// EMPTY STATE
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.download_done_outlined,
          size: 80,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        const Text(
          'No Downloads Yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'All your downloaded CVs will appear here.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16), 
      ],
    ),
  );
}),
                  /// Free Templates
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Free Templates",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: files.map((file) {
                        final url = AppwriteStorageService.getImageUrl(
                          file.$id,
                        );
                        return _templateCard(
                          title: file.name,
                          imageUrl: url,
                          onTap: () => _showTemplatePreview(url, file.name),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 25),

                  /// Premium Templates
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Premium Templates",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .75,
                    children: files.map((file) {
                      final url = AppwriteStorageService.getImageUrl(file.$id);
                      return _templateCard(
                        title: file.name,
                        imageUrl: url,
                        isPremium: true,
                        onTap: () => _showTemplatePreview(
                          url,
                          file.name,
                          isPremium: true,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),

      /// FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0048ff),
        elevation: 8,
        child: const Icon(Icons.add, size: 30),
        onPressed: () => Get.to(() => const GenrateCvScreen()),
      ),
    );
  }

  Widget _templateCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
    bool isPremium = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(blurRadius: 8, color: Colors.black12),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (isPremium)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "PRO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _drawerItem(icon, title, onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }

  Color _getTemplateColor(templateNumber) {
    switch (templateNumber) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';

    DateTime date;
    if (timestamp is DateTime) {
      date = timestamp;
    } else if (timestamp is String) {
      date = DateTime.parse(timestamp);
    } else {
      return 'Unknown';
    }

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'mins'} ago';
    } else {
      return 'Just now';
    }
  }
}
