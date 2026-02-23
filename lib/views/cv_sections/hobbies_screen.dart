import 'package:cvmaker/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/portfolio_controller.dart';
import '../../widgets/banner_ad_widget.dart';

class HobbiesScreen extends StatelessWidget {
  const HobbiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final hobbyController = TextEditingController();

    return Scaffold(
          appBar: CustomBlueAppBar(
        rightText: "Add",
        onRightTap: () {
              Get.dialog(
                Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Add Hobby',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: hobbyController,
                          decoration: const InputDecoration(
                            labelText: 'Hobby Name',
                            border: OutlineInputBorder(),
                          ),
                          autofocus: true,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                hobbyController.clear();
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (hobbyController.text.trim().isNotEmpty) {
                                  controller.addHobby(hobbyController.text);
                                  hobbyController.clear();
                                  Get.back();
                                  Get.snackbar('Success', 'Hobby added',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white);
                                }
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
        title: "Hobbies",
      ),
      
    body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.hobbies.isEmpty) {
                return const Center(
                  child: Text('No hobbies added yet'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = controller.hobbies[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(hobby.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          controller.removeHobby(hobby.id);
                          Get.snackbar('Success', 'Hobby removed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const BannerAdWidget(),
        ],
      ),
    );
  }
}
