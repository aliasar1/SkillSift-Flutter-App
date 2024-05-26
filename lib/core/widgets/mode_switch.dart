import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../constants/theme/controller/theme_controller.dart';

class ModeSwitch extends StatefulWidget {
  const ModeSwitch({super.key});

  @override
  State<ModeSwitch> createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {
  final controller = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: Get.width * 0.04),
        Icon(
          controller.isDarkMode
              ? Icons.nightlight_round
              : Icons.wb_sunny_rounded,
          size: 24.0,
          color: LightTheme.primaryColor,
        ),
        SizedBox(width: Get.width * 0.08),
        Switch(
            value: controller.isDarkMode,
            onChanged: (_) {
              setState(() {
                controller.toggleTheme();
              });
            },
            activeColor: controller.isDarkMode
                ? DarkTheme.primaryColor
                : LightTheme.primaryColorLightestShade,
            inactiveTrackColor: controller.isDarkMode
                ? DarkTheme.primaryColor.withOpacity(0.5)
                : LightTheme.primaryColorLightestShade.withOpacity(0.5),
            inactiveThumbColor: DarkTheme.primaryColor),
      ],
    );
  }
}
