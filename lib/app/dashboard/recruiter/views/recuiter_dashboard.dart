import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../components/recruiter_jobs_screen.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: CustomButton(
            color: LightTheme.primaryColor,
            hasInfiniteWidth: true,
            buttonType: ButtonType.textWithImage,
            onPressed: () {
              Get.to(RecruiterJobsScreen());
            },
            image: const Icon(
              Icons.account_box,
              color: LightTheme.white,
            ),
            text: "Manage Jobs",
            constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
            buttonPadding: const EdgeInsets.all(0),
            customTextStyle: const TextStyle(
                fontSize: Sizes.TEXT_SIZE_12,
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.normal),
            textColor: LightTheme.white,
          ),
        ),
      ),
    ));
  }
}
