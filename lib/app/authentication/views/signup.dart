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
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
              child: SignupForm(
                controller: controller,
                isRecruiter: isRecruiter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}