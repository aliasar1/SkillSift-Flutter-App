import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/views_exports.dart';
import '../../intro_slider/views/intro_page.dart';
import '../components/login_form.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/loginScreen';

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(IntroScreen());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_8),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.question_mark,
                      color: LightTheme.secondaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              LoginForm(
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
