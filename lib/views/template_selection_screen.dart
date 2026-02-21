import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/banner_ad_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TemplateSelectionScreen extends StatefulWidget {
  final bool isForShare;

  const TemplateSelectionScreen({super.key, this.isForShare = false});

  @override
  State<TemplateSelectionScreen> createState() =>
      _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {
  // interstitial logic no longer used; preview uses a fake delay dialog

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select PDF Template')),
      // reserve a fixed height for the banner so the body is always sized above it
      bottomNavigationBar: SizedBox(
        height: AdSize.banner.height.toDouble(),
        child: const BannerAdWidget(),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  16 + AdSize.banner.height.toDouble(),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.8,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final templateNumber = index + 1;
                  return Obx(
                    () => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapDown: (_) => controller.setTemplate(templateNumber),
                      child: Card(
                        elevation: controller.selectedTemplate == templateNumber
                            ? 8
                            : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: controller.selectedTemplate == templateNumber
                              ? const BorderSide(color: Colors.blue, width: 2)
                              : BorderSide.none,
                        ),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Template Preview
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _getTemplateColor(templateNumber),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      _getTemplateIcon(templateNumber),
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Template number badge
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),

                                      child: Text(
                                        'Template $templateNumber',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Template Info
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getTemplateName(templateNumber),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getTemplateDescription(templateNumber),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),

                                  // Action Buttons
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _buildActionButton(
                                        icon: Icons.remove_red_eye,
                                        label: 'Preview',
                                        onTap: () {
                                          debugPrint('Preview tap on template $templateNumber');
                                          // mark the selected template so preview screen knows
                                          controller.setTemplate(templateNumber);
                                          // show ad placeholder then navigate
                                          _showAdThen(() {
                                            debugPrint('Navigating to preview after ad');
                                            Get.toNamed('/preview');
                                          });
                                        },
                                      ),
                                      Container(
                                        height: 20,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),
                                      // In the action buttons section, replace the Download button with:
                                      _buildActionButton(
                                        icon: Icons.download,
                                        label: 'Download',
                                        onTap: () async {
                                          debugPrint('Download tap on template $templateNumber');
                                          try {
                                            controller.setTemplate(templateNumber);
                                            await controller.generateAndSavePdf(
                                              templateNumber: templateNumber,
                                            );
                                            debugPrint('PDF generated successfully');
                                          } catch (e) {
                                            debugPrint('Download error: $e');
                                            Get.snackbar(
                                              'Error',
                                              'Failed to generate PDF: $e',
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.blue),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }



  Color _getTemplateColor(int templateNumber) {
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

  IconData _getTemplateIcon(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return Icons.description;
      case 2:
        return Icons.view_column;
      case 3:
        return Icons.center_focus_strong;
      case 4:
        return Icons.view_agenda;
      case 5:
        return Icons.palette;
      default:
        return Icons.description;
    }
  }

  String _getTemplateName(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return 'Classic Professional';
      case 2:
        return 'Modern Sidebar';
      case 3:
        return 'Minimalist';
      case 4:
        return 'Two Column';
      case 5:
        return 'Creative Colors';
      default:
        return 'Template $templateNumber';
    }
  }

  String _getTemplateDescription(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return 'Clean and professional layout with sections for all your information';
      case 2:
        return 'Modern design with colored sidebar for contact and skills';
      case 3:
        return 'Simple and elegant minimalist design';
      case 4:
        return 'Efficient two-column layout for maximum information density';
      case 5:
        return 'Creative design with gradient header and card sections';
      default:
        return 'Template $templateNumber';
    }
  }



  Future<void> _showAdThen(VoidCallback onAdCompleted) async {
    if (!mounted) {
      debugPrint('Not mounted, skipping ad dialog');
      onAdCompleted();
      return;
    }

    debugPrint('Showing ad dialog');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      debugPrint('Closing ad dialog and executing callback');
      Navigator.pop(context);
      onAdCompleted();
    }
  }
}
