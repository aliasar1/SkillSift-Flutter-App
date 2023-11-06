import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';

import '../core/constants/theme/light_theme.dart';
import '../core/exports/constants_exports.dart';
import '../core/exports/widgets_export.dart';
import 'intro_slider/views/intro_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = AuthController();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.offAll(IntroScreen()),
    );
    // Timer(const Duration(seconds: 3), () => controller.checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.APP_LOGO,
                height: Sizes.ICON_SIZE_50 * 2,
                width: Sizes.ICON_SIZE_50 * 5,
              ),
              const Txt(
                title: AppStrings.APP_HOOK_LINE,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.primaryColor,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
