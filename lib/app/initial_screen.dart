import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Get.offAll(IntroPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: LightTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline_outlined,
              color: LightTheme.white,
              size: Sizes.ICON_SIZE_50 * 3,
            ),
            Txt(
              title: AppStrings.APP_NAME,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.white,
                fontSize: Sizes.TEXT_SIZE_24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Txt(
              title: AppStrings.APP_HOOK_LINE,
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.white,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
