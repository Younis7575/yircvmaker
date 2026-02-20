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
                                          controller.setTemplate(templateNumber);
                                          _showAdThen(() {
                                            debugPrint('Showing preview after ad');
                                            _showTemplatePreview(
                                              context,
                                              templateNumber,
                                              controller,
                                            );
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

  void _showTemplatePreview(
    BuildContext context,
    int templateNumber,
    PortfolioController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // wrap the whole sheet in a SafeArea so that the bottom padding
        // (navigation bar / gesture area) doesn't cause an overflow.
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.85,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Template ${_getTemplateName(templateNumber)} Preview',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Preview Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Template Preview Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Sample Header
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: _getTemplateColor(templateNumber),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 16,
                                            color: Colors.grey[300],
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            width: 100,
                                            height: 12,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Sample Sections
                                ...List.generate(4, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 14,
                                          color: _getTemplateColor(
                                            templateNumber,
                                          ).withValues(alpha: 0.5),

                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: double.infinity,
                                          height: 10,
                                          color: Colors.grey[300],
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          width: 200,
                                          height: 10,
                                          color: Colors.grey[300],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Template Description
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Template Features:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ..._getTemplateFeatures(templateNumber).map(
                                    (feature) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(child: Text(feature)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                          label: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Navigator.pop(context);
                            await controller.generateAndSavePdf(
                              templateNumber: templateNumber,
                            );
                            // _showDownloadNotification(templateNumber);
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

  List<String> _getTemplateFeatures(int templateNumber) {
    switch (templateNumber) {
      case 1:
        return [
          'Professional header with profile image',
          'Chronological sections',
          'Skill chips with modern design',
          'Clean typography',
          'Perfect for corporate jobs',
        ];
      case 2:
        return [
          'Colored sidebar for contact info',
          'Profile image in sidebar',
          'Main content area for details',
          'Modern color scheme',
          'Great for creative roles',
        ];
      case 3:
        return [
          'Centered header design',
          'Minimalist layout',
          'Elegant spacing',
          'Focus on content',
          'Perfect for artists and designers',
        ];
      case 4:
        return [
          'Two-column layout',
          'Efficient space utilization',
          'Clear section separation',
          'Good for experienced professionals',
          'Maximizes information display',
        ];
      case 5:
        return [
          'Gradient header',
          'Card-based sections',
          'Creative color scheme',
          'Modern UI elements',
          'Stand out from the crowd',
        ];
      default:
        return ['Template features'];
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
