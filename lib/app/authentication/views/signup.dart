import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../components/signup_form.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key, required this.isRecruiter});

  static const String routeName = '/signupScreen';

  final controller = Get.put(AuthController());
  final bool isRecruiter;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
              vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
          child: Center(
            child: SignupForm(
              controller: controller,
              isRecruiter: isRecruiter,
            ),
          ),
        ),
      ),
    );
  }
}
