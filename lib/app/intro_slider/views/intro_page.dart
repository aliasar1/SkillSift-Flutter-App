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
        indicatorConfig: IndicatorConfig(
            colorActiveIndicator:
                isDarkMode ? DarkTheme.whiteColor : LightTheme.blackShade1,
            colorIndicator:
                isDarkMode ? DarkTheme.lightGreyColor : LightTheme.greyShade7),
        doneButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
                isDarkMode ? DarkTheme.whiteColor : LightTheme.black)),
        skipButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
                isDarkMode ? DarkTheme.whiteColor : LightTheme.black)),
        nextButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
                isDarkMode ? DarkTheme.whiteColor : LightTheme.black)),
      ),
    );
  }
}
