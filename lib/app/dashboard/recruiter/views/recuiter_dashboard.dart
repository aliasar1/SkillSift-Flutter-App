import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../authentication/controllers/auth_controller.dart';

class RecruiterDashboard extends StatelessWidget {
  RecruiterDashboard({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor: LightTheme.whiteShade2,
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text('This is recruiter dashboard!'),
      ),
    ));
  }
}
