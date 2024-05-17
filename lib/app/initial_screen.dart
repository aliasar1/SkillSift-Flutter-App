import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/exports/constants_exports.dart';
import '../core/exports/widgets_export.dart';
import 'authentication/controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => controller.checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      body: GetBuilder<AuthController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: LightTheme.whiteShade2,
                color: LightTheme.primaryColor,
              ),
            );
          } else {
            return Center(
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
            );
          }
        },
      ),
    );
  }
}
