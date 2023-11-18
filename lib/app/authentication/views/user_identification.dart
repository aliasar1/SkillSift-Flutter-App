import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../components/user_identification_container.dart';

class UserIdentificationScreen extends StatelessWidget {
  const UserIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: LightTheme.secondaryColor),
        ),
        body: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            Image.asset(
              AppAssets.APP_ICON,
              height: Sizes.ICON_SIZE_50 * 2,
              width: Sizes.ICON_SIZE_50 * 3,
            ),
            Image.asset(
              AppAssets.APP_TEXT,
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
