import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';

class DraftScreen extends StatelessWidget {
  DraftScreen({super.key, required this.role});
  final String role;

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => controller.logout(), icon: Icon(Icons.logout))
      ]),
      body: Center(child: Text(role)),
    );
  }
}
