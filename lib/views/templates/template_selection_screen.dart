// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/portfolio_controller.dart';
// import '../../widgets/banner_ad_widget.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class TemplateSelectionScreen extends StatefulWidget {
//   final bool isForShare;
//   const TemplateSelectionScreen({super.key, this.isForShare = false});

//   @override
//   State<TemplateSelectionScreen> createState() => _TemplateSelectionScreenState();
// }

// class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<PortfolioController>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Select CV Template')),
//       bottomNavigationBar: SizedBox(
//         height: AdSize.banner.height.toDouble(),
//         child: const BannerAdWidget(),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: GridView.builder(
//           padding: EdgeInsets.fromLTRB(14, 14, 14, 14 + AdSize.banner.height.toDouble()),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.72,
//           ),
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             final n = index + 1;
//             return Obx(() {
//               final isSelected = controller.selectedTemplate == n;
//               return GestureDetector(
//                 onTapDown: (_) => controller.setTemplate(n),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(
//                       color: isSelected ? _getAccentColor(n) : Colors.transparent,
//                       width: 2.5,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: isSelected
//                             ? _getAccentColor(n).withOpacity(0.35)
//                             : Colors.black.withOpacity(0.08),
//                         blurRadius: isSelected ? 10 : 4,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Material(
//                       color: Colors.white,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // ── PREVIEW AREA
//                           Expanded(
//                             flex: 5,
//                             child: _buildMiniPreview(n),
//                           ),
//                           // ── INFO + BUTTONS
//                           Expanded(
//                             flex: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(children: [
//                                     Container(
//                                       width: 6, height: 6,
//                                       decoration: BoxDecoration(
//                                         color: _getAccentColor(n),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Expanded(
//                                       child: Text(
//                                         _getTemplateName(n),
//                                         style: const TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ]),
//                                   Text(
//                                     _getTemplateTag(n),
//                                     style: TextStyle(fontSize: 8, color: Colors.grey[500]),
//                                     maxLines: 1,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: _actionBtn(
//                                           icon: Icons.remove_red_eye_outlined,
//                                           label: 'Preview',
//                                           color: _getAccentColor(n),
//                                           onTap: () {
//                                             controller.setTemplate(n);
//                                             _showAdThen(() => Get.toNamed('/preview'));
//                                           },
//                                         ),
//                                       ),
//                                       Container(width: 1, height: 22, color: Colors.grey[200]),
//                                       Expanded(
//                                         child: _actionBtn(
//                                           icon: Icons.download_rounded,
//                                           label: 'Download',
//                                           color: _getAccentColor(n),
//                                           onTap: () async {
//                                             controller.setTemplate(n);
//                                             try {
//                                               await controller.generateAndSavePdf(templateNumber: n);
//                                             } catch (e) {
//                                               Get.snackbar('Error', 'Failed: $e',
//                                                 snackPosition: SnackPosition.BOTTOM,
//                                                 backgroundColor: Colors.red,
//                                                 colorText: Colors.white);
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             });
//           },
//         ),
//       ),
//     );
//   }

// Widget _buildMiniPreview(int n) {
//   final accent = _getAccentColor(n);
//   final isDark = n == 2 || n == 9;
//   final isBW   = n == 3 || n == 8;

//   // Get the background color based on template
//   Color bgColor;
//   if (isDark) {
//     bgColor = const Color(0xFF1A1A2E);
//   } else if (isBW) {
//     bgColor = Colors.white;
//   } else {
//     bgColor = Colors.grey[50]!;
//   }

//   return Container(
//     decoration: BoxDecoration(
//       color: bgColor,  // Move color inside decoration
//     ),
//     child: Stack(
//       children: [
//         // Layout simulation
//         _miniLayout(n, accent, isDark, isBW),
//         // Selected checkmark
//         Positioned(
//           top: 6, right: 6,
//           child: Obx(() => controller.selectedTemplate == n
//             ? Container(
//                 width: 18, height: 18,
//                 decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
//                 child: const Icon(Icons.check, color: Colors.white, size: 11),
//               )
//             : const SizedBox.shrink()),
//         ),
//         // Template badge
//         Positioned(
//           top: 6, left: 6,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//             decoration: BoxDecoration(
//               color: isDark ? Colors.white12 : Colors.black26,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               'T$n',
//               style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _miniLayout(int n, Color accent, bool isDark, bool isBW) {
//     // Sidebar layouts: 1, 2(dark), 6(purple), 8(bw black), 9(navy)
//     final hasSidebar = [1, 2, 6, 8, 9].contains(n);
//     // Top bar layouts: 4(green), 5(teal), 7(orange), 10(red)
//     final hasTopBar = [4, 5, 7, 10].contains(n);
//     // Pure 2-col: 3(bw)
//     final pure2col  = n == 3;

//     if (hasSidebar) {
//       return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         // sidebar
//         Container(
//           width: 40,
//           color: n == 8 ? Colors.black : n == 9 ? const Color(0xFF0D1B2A) : accent,
//           child: Column(children: [
//             Container(
//               height: 36,
//               color: (n == 8 ? Colors.black : accent).withOpacity(0.85),
//               child: Center(child: Container(
//                 width: 20, height: 20,
//                 decoration: BoxDecoration(shape: BoxShape.circle,
//                   color: Colors.white24,
//                   border: Border.all(color: Colors.white54, width: 1)),
//               )),
//             ),
//             const SizedBox(height: 6),
//             ..._miniLines(Colors.white54, count: 5, width: 28, leftPad: 6),
//           ]),
//         ),
//         // main
//         Expanded(child: Padding(
//           padding: const EdgeInsets.all(6),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             _miniSecTitle(accent, isBW || isDark ? const Color(0xFF1A1A1A) : accent),
//             ..._miniLines(isBW ? Colors.black26 : isDark ? Colors.white24 : Colors.black12, count: 4),
//             const SizedBox(height: 5),
//             _miniSecTitle(accent, isBW || isDark ? const Color(0xFF1A1A1A) : accent),
//             ..._miniLines(isBW ? Colors.black26 : isDark ? Colors.white24 : Colors.black12, count: 3),
//           ]),
//         )),
//       ]);
//     }

//     if (hasTopBar) {
//       return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//         // top bar
//         Container(
//           height: 38,
//           color: accent,
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//           child: Row(children: [
//             Container(width: 24, height: 24,
//               decoration: BoxDecoration(shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white70, width: 1.5),
//                 color: Colors.white24)),
//             const SizedBox(width: 6),
//             Column(crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(width: 45, height: 5, color: Colors.white70),
//                 const SizedBox(height: 3),
//                 Container(width: 30, height: 3, color: Colors.white38),
//               ]),
//           ]),
//         ),
//         // 2-col body
//         Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           Container(
//             width: 42,
//             color: accent.withOpacity(0.12),
//             padding: const EdgeInsets.all(5),
//             child: Column(children: [
//               ..._miniLines(accent.withOpacity(0.4), count: 5),
//             ]),
//           ),
//           Expanded(child: Padding(
//             padding: const EdgeInsets.all(5),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               ..._miniLines(Colors.black12, count: 6),
//             ]),
//           )),
//         ])),
//       ]);
//     }

//     // pure 2-col (T3 B&W)
//     return Padding(
//       padding: const EdgeInsets.all(7),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Container(height: 6, width: 70, color: Colors.black87),
//         const SizedBox(height: 2),
//         Container(height: 3, width: 45, color: Colors.black38),
//         const SizedBox(height: 4),
//         Container(height: 1, color: Colors.black),
//         const SizedBox(height: 5),
//         Expanded(child: Row(children: [
//           Expanded(flex: 6, child: Column(children: [
//             ..._miniLines(Colors.black12, count: 6),
//           ])),
//           Container(width: 1, color: Colors.black12, margin: const EdgeInsets.symmetric(horizontal: 4)),
//           Expanded(flex: 4, child: Column(children: [
//             ..._miniLines(Colors.black12, count: 5),
//           ])),
//         ])),
//       ]),
//     );
//   }

//   List<Widget> _miniLines(Color color, {int count = 3, double? width, double leftPad = 0}) {
//     return List.generate(count, (i) => Padding(
//       padding: EdgeInsets.only(left: leftPad, bottom: 3, right: leftPad > 0 ? leftPad : 0),
//       child: Container(
//         height: 3.5,
//         width: width,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(2),
//         ),
//       ),
//     ));
//   }

// Widget _miniSecTitle(Color accent, Color textColor) => Padding(
//   padding: const EdgeInsets.only(bottom: 3),
//   child: Row(children: [
//     Container(
//       width: 2, 
//       height: 8, 
//       color: accent,  // ✅ This is fine - no decoration
//     ),
//     const SizedBox(width: 3),
//     Container(
//       width: 35, 
//       height: 4,
//       decoration: BoxDecoration(
//         color: accent.withOpacity(0.6),  // ✅ Moved color inside decoration
//         borderRadius: BorderRadius.circular(1),
//       ),
//     ),
//   ]),
// );

//   Widget _actionBtn({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 3),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Icon(icon, size: 14, color: color),
//           Text(label, style: TextStyle(fontSize: 9, color: color)),
//         ]),
//       ),
//     );
//   }

//   Color _getAccentColor(int n) {
//     switch (n) {
//       case 1:  return const Color(0xFF1565C0); // Blue
//       case 2:  return const Color(0xFFE94560); // Dark Red
//       case 3:  return Colors.black;            // B&W
//       case 4:  return const Color(0xFF2E7D32); // Green
//       case 5:  return const Color(0xFF00695C); // Teal
//       case 6:  return const Color(0xFF6A1B9A); // Purple
//       case 7:  return const Color(0xFFE65100); // Orange
//       case 8:  return Colors.black;            // B&W Elegant
//       case 9:  return const Color(0xFFD4AF37); // Gold
//       case 10: return const Color(0xFFC62828); // Red
//       default: return Colors.blue;
//     }
//   }

//   String _getTemplateName(int n) {
//     switch (n) {
//       case 1:  return 'Classic Blue';
//       case 2:  return 'Dark Red Hero';
//       case 3:  return 'B&W Minimalist';
//       case 4:  return 'Green Modern';
//       case 5:  return 'Teal Cards';
//       case 6:  return 'Purple Timeline';
//       case 7:  return 'Orange Infographic';
//       case 8:  return 'B&W Elegant';
//       case 9:  return 'Navy & Gold';
//       case 10: return 'Red Bold';
//       default: return 'Template $n';
//     }
//   }

//   String _getTemplateTag(int n) {
//     switch (n) {
//       case 1:  return 'Sidebar · Colored';
//       case 2:  return 'Dark · Full Page';
//       case 3:  return 'Black & White';
//       case 4:  return 'Top Bar · 2-Col';
//       case 5:  return 'Cards · Teal';
//       case 6:  return 'Timeline · Purple';
//       case 7:  return 'Skill Bars · Bold';
//       case 8:  return 'Black Sidebar · B&W';
//       case 9:  return 'Dark · Luxury Gold';
//       case 10: return 'Bold · Red Accent';
//       default: return '';
//     }
//   }

//   PortfolioController get controller => Get.find<PortfolioController>();

//   Future<void> _showAdThen(VoidCallback onAdCompleted) async {
//     if (!mounted) { onAdCompleted(); return; }
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => const Center(child: CircularProgressIndicator()),
//     );
//     await Future.delayed(const Duration(seconds: 2));
//     if (mounted) { Navigator.pop(context); onAdCompleted(); }
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../widgets/banner_ad_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TemplateSelectionScreen extends StatefulWidget {
  final bool isForShare;
  const TemplateSelectionScreen({super.key, this.isForShare = false});

  @override
  State<TemplateSelectionScreen> createState() => _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select CV Template')),
      bottomNavigationBar: SizedBox(
        height: AdSize.banner.height.toDouble(),
        child: const BannerAdWidget(),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.fromLTRB(14, 14, 14, 14 + AdSize.banner.height.toDouble()),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final n = index + 1;
            return Obx(() {
              final isSelected = controller.selectedTemplate == n;
              return GestureDetector(
                onTapDown: (_) => controller.setTemplate(n),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? _getAccentColor(n) : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? _getAccentColor(n).withOpacity(0.35)
                            : Colors.black.withOpacity(0.08),
                        blurRadius: isSelected ? 10 : 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ── PREVIEW AREA
                          Expanded(
                            flex: 5,
                            child: _buildMiniPreview(n),
                          ),
                          // ── INFO + BUTTONS
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      width: 6, height: 6,
                                      decoration: BoxDecoration(
                                        color: _getAccentColor(n),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        _getTemplateName(n),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                                  Text(
                                    _getTemplateTag(n),
                                    style: TextStyle(fontSize: 8, color: Colors.grey[500]),
                                    maxLines: 1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _actionBtn(
                                          icon: Icons.remove_red_eye_outlined,
                                          label: 'Preview',
                                          color: _getAccentColor(n),
                                          onTap: () {
                                            controller.setTemplate(n);
                                            _showAdThen(() => Get.toNamed('/preview'));
                                          },
                                        ),
                                      ),
                                      Container(width: 1, height: 22, color: Colors.grey[200]),
                                      Expanded(
                                        child: _actionBtn(
                                          icon: Icons.download_rounded,
                                          label: 'Download',
                                          color: _getAccentColor(n),
                                          onTap: () async {
                                            controller.setTemplate(n);
                                            try {
                                              await controller.generateAndSavePdf(templateNumber: n);
                                            } catch (e) {
                                              Get.snackbar('Error', 'Failed: $e',
                                                snackPosition: SnackPosition.BOTTOM,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white);
                                            }
                                          },
                                        ),
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
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildMiniPreview(int n) {
    final accent = _getAccentColor(n);
    final isDark = n == 2 || n == 9;
    final isBW   = n == 3 || n == 8;

    // Get the background color based on template
    Color bgColor;
    if (isDark) {
      bgColor = const Color(0xFF1A1A2E);
    } else if (isBW) {
      bgColor = Colors.white;
    } else {
      bgColor = Colors.grey[50]!;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Stack(
        children: [
          // Layout simulation
          _miniLayout(n, accent, isDark, isBW),
          // Selected checkmark
          Positioned(
            top: 6, right: 6,
            child: Obx(() => controller.selectedTemplate == n
              ? Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 11),
                )
              : const SizedBox.shrink()),
          ),
          // Template badge
          Positioned(
            top: 6, left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark ? Colors.white12 : Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'T$n',
                style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniLayout(int n, Color accent, bool isDark, bool isBW) {
    // Sidebar layouts: 1, 2(dark), 6(purple), 8(bw black), 9(navy)
    final hasSidebar = [1, 2, 6, 8, 9].contains(n);
    // Top bar layouts: 4(green), 5(teal), 7(orange), 10(red)
    final hasTopBar = [4, 5, 7, 10].contains(n);
    // Pure 2-col: 3(bw)
    final pure2col  = n == 3;

    if (hasSidebar) {
      return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // sidebar
        Container(
          width: 40,
          color: n == 8 ? Colors.black : n == 9 ? const Color(0xFF0D1B2A) : accent,
          child: Column(children: [
            Container(
              height: 36,
              color: (n == 8 ? Colors.black : accent).withOpacity(0.85),
              child: Center(
                child: Container(
                  width: 20, 
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                    border: Border.all(color: Colors.white54, width: 1)
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            ..._miniLines(Colors.white54, count: 5, width: 28, leftPad: 6),
          ]),
        ),
        // main
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                _miniSecTitle(accent, isBW || isDark ? const Color(0xFF1A1A1A) : accent),
                ..._miniLines(isBW ? Colors.black26 : isDark ? Colors.white24 : Colors.black12, count: 4),
                const SizedBox(height: 5),
                _miniSecTitle(accent, isBW || isDark ? const Color(0xFF1A1A1A) : accent),
                ..._miniLines(isBW ? Colors.black26 : isDark ? Colors.white24 : Colors.black12, count: 3),
              ],
            ),
          ),
        ),
      ]);
    }

    if (hasTopBar) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // top bar
        Container(
          height: 38,
          color: accent,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(children: [
            Container(
              width: 24, 
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white70, width: 1.5),
                color: Colors.white24
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 45, height: 5, color: Colors.white70),
                const SizedBox(height: 3),
                Container(width: 30, height: 3, color: Colors.white38),
              ],
            ),
          ]),
        ),
        // 2-col body
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              Container(
                width: 42,
                color: accent.withOpacity(0.12),
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  ..._miniLines(accent.withOpacity(0.4), count: 5),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, 
                    children: [
                      ..._miniLines(Colors.black12, count: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]);
    }

    // pure 2-col (T3 B&W)
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(height: 6, width: 70, color: Colors.black87),
          const SizedBox(height: 2),
          Container(height: 3, width: 45, color: Colors.black38),
          const SizedBox(height: 4),
          Container(height: 1, color: Colors.black),
          const SizedBox(height: 5),
          Expanded(
            child: Row(children: [
              Expanded(
                flex: 6, 
                child: Column(children: [
                  ..._miniLines(Colors.black12, count: 6),
                ]),
              ),
              Container(
                width: 1, 
                color: Colors.black12, 
                margin: const EdgeInsets.symmetric(horizontal: 4)
              ),
              Expanded(
                flex: 4, 
                child: Column(children: [
                  ..._miniLines(Colors.black12, count: 5),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  List<Widget> _miniLines(Color color, {int count = 3, double? width, double leftPad = 0}) {
    return List.generate(count, (i) => Padding(
      padding: EdgeInsets.only(left: leftPad, bottom: 3, right: leftPad > 0 ? leftPad : 0),
      child: Container(
        height: 3.5,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ));
  }

  // FIXED: This method no longer uses both color and decoration
  Widget _miniSecTitle(Color accent, Color textColor) => Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(children: [
      Container(
        width: 2, 
        height: 8, 
        color: accent,
      ),
      const SizedBox(width: 3),
      Container(
        width: 35, 
        height: 4,
        decoration: BoxDecoration(
          color: accent.withOpacity(0.6),
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    ]),
  );

  Widget _actionBtn({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 14, color: color),
          Text(label, style: TextStyle(fontSize: 9, color: color)),
        ]),
      ),
    );
  }

  Color _getAccentColor(int n) {
    switch (n) {
      case 1:  return const Color(0xFF1565C0); // Blue
      case 2:  return const Color(0xFFE94560); // Dark Red
      case 3:  return Colors.black;            // B&W
      case 4:  return const Color(0xFF2E7D32); // Green
      case 5:  return const Color(0xFF00695C); // Teal
      case 6:  return const Color(0xFF6A1B9A); // Purple
      case 7:  return const Color(0xFFE65100); // Orange
      case 8:  return Colors.black;            // B&W Elegant
      case 9:  return const Color(0xFFD4AF37); // Gold
      case 10: return const Color(0xFFC62828); // Red
      default: return Colors.blue;
    }
  }

  String _getTemplateName(int n) {
    switch (n) {
      case 1:  return 'Classic Blue';
      case 2:  return 'Dark Red Hero';
      case 3:  return 'B&W Minimalist';
      case 4:  return 'Green Modern';
      case 5:  return 'Teal Cards';
      case 6:  return 'Purple Timeline';
      case 7:  return 'Orange Infographic';
      case 8:  return 'B&W Elegant';
      case 9:  return 'Navy & Gold';
      case 10: return 'Red Bold';
      default: return 'Template $n';
    }
  }

  String _getTemplateTag(int n) {
    switch (n) {
      case 1:  return 'Sidebar · Colored';
      case 2:  return 'Dark · Full Page';
      case 3:  return 'Black & White';
      case 4:  return 'Top Bar · 2-Col';
      case 5:  return 'Cards · Teal';
      case 6:  return 'Timeline · Purple';
      case 7:  return 'Skill Bars · Bold';
      case 8:  return 'Black Sidebar · B&W';
      case 9:  return 'Dark · Luxury Gold';
      case 10: return 'Bold · Red Accent';
      default: return '';
    }
  }

  PortfolioController get controller => Get.find<PortfolioController>();

  Future<void> _showAdThen(VoidCallback onAdCompleted) async {
    if (!mounted) { onAdCompleted(); return; }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) { Navigator.pop(context); onAdCompleted(); }
  }
}