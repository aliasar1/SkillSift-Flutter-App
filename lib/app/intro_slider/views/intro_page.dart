import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../controllers/slider_controller.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({super.key});

  static const String routeName = '/introScreen';

  final sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        body: IntroSlider(
          key: UniqueKey(),
          listCustomTabs: sliderController.listCustomTabs,
          onDonePress: sliderController.onDoneOrSkipPress,
          onSkipPress: sliderController.onDoneOrSkipPress,
        ),
      ),
    );
  }
}
