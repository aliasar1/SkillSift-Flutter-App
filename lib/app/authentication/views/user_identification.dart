import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../components/user_identification_container.dart';

class UserIdentificationScreen extends StatelessWidget {
  const UserIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: isDarkMode
                ? DarkTheme.whiteGreyColor
                : LightTheme.secondaryColor),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Image.asset(
              isDarkMode ? AppAssets.APP_ICON_DARK : AppAssets.APP_ICON,
              height: Sizes.ICON_SIZE_50 * 1.6,
              width: Sizes.ICON_SIZE_50 * 3,
            ),
            Image.asset(
              isDarkMode ? AppAssets.APP_TEXT_DARK : AppAssets.APP_TEXT,
              height: Sizes.ICON_SIZE_50 * 2,
              width: Sizes.ICON_SIZE_50 * 4,
            ),
            const UserIdentificationContainer(),
          ],
        ),
      ),
    );
  }
}
