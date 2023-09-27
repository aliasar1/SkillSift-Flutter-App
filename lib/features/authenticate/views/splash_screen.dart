import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/new_slider.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

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
      () => Get.offAll(IntroSlider()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.secondaryColorDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline_outlined,
              color: AppColors.white,
              size: Sizes.ICON_SIZE_50 * 3,
            ),
            Txt(
              title: AppStrings.APP_NAME,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: AppColors.white,
                fontSize: Sizes.TEXT_SIZE_24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Txt(
              title: AppStrings.APP_HOOK_LINE,
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: AppColors.white,
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
