import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';

import '../controllers/slider_controller.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  static const String routeName = '/introScreen';

  final sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: IntroSlider(
        key: UniqueKey(),
        listCustomTabs: sliderController.listCustomTabs,
        onDonePress: sliderController.onDoneOrSkipPress,
        onSkipPress: sliderController.onDoneOrSkipPress,
        indicatorConfig: const IndicatorConfig(
            colorActiveIndicator: DarkTheme.whiteColor,
            colorIndicator: DarkTheme.lightGreyColor),
        doneButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(DarkTheme.whiteColor)),
        skipButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(DarkTheme.whiteColor)),
        nextButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(DarkTheme.whiteColor)),
      ),
    );
  }
}
