import 'dart:io';
import 'package:cvmaker/controllers/payment_controller.dart';
import 'package:cvmaker/views/payments/orders_screen.dart';
import 'package:cvmaker/widgets/app_bar.dart';
import 'package:cvmaker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  final String templateName;
  final String imageUrl;

  PaymentScreen({
    super.key,
    required this.templateName,
    required this.imageUrl,
  });

  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBlueAppBar(title: "Premium Payment"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// CV IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, height: 200),
              ),
          
              const SizedBox(height: 20),
          
              /// Jazzcash
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "JazzCash: 03342322324",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          
              const SizedBox(height: 15),
          
              /// Bank
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bank: United Bank Limited\nIBAN: PK11UBLP000000000000123456789",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
          
              /// TRX FIELD
              TextField(
                onChanged: (v) => controller.trxId.value = v,
                decoration: InputDecoration(
                  labelText: "TRX ID",
                  border: OutlineInputBorder(),
                ),
              ),
          
              const SizedBox(height: 20),
          
              /// Screenshot Upload
              Obx(
                () => controller.imagePath.value == ""
                    ? Container(
                        width: 350,
                        child: PrimaryButton(
                          onPressed: controller.pickImage,
                          icon: Icon(Icons.upload),
                          label: "Upload Screenshot",
                        ),
                      )
                    : Image.file(File(controller.imagePath.value), height: 120),
              ),
          
              const SizedBox(height: 20),
              Container(
                width: 350,
                child: PrimaryButton(
                  onPressed: () {
                    controller.submitOrder(templateName, imageUrl);
          
                    Get.off(() => const OrdersScreen());
                  },
                  icon: Icon(Icons.upload),
                  label: "Submit Payment",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
