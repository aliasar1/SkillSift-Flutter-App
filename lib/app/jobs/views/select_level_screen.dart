import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/jobs/views/level2_application_screen.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:skillsift_flutter_app/core/services/application_api.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import 'current_applications_screen.dart';
import 'level3_application_screen.dart';

class SelectLevelScreen extends StatefulWidget {
  const SelectLevelScreen(
      {super.key, required this.jobId, required this.jobTitle});

  final String jobId;
  final String jobTitle;

  @override
  State<SelectLevelScreen> createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends State<SelectLevelScreen> {
  int maxLevel = -1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    maxLevel = await ApplicationApi.findTheMaxLevel(widget.jobId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      ),
      body: isLoading
          ? const Center(
              child: SpinKitHourGlass(
                color: LightTheme.primaryColor,
                size: 50.0,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_20,
                vertical: Sizes.MARGIN_20,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      isDarkMode ? AppAssets.APP_ICON_DARK : AppAssets.APP_ICON,
                      height: Sizes.ICON_SIZE_50 * 2.5,
                      width: Sizes.ICON_SIZE_50 * 2.5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Txt(
                      title:
                          "Select the level, you want to see the candidates.",
                      textAlign: TextAlign.center,
                      fontContainerWidth: Get.width * 0.7,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: maxLevel >= 1
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: maxLevel >= 1
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 1",
                      onPressed: () {
                        if (maxLevel >= 1) {
                          Get.to(CurrentApplicationScreen(
                            jobId: widget.jobId,
                            jobTitle: widget.jobTitle,
                          ));
                        }
                      },
                      hasInfiniteWidth: true,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: maxLevel >= 2
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: maxLevel >= 2
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 2",
                      onPressed: () {
                        if (maxLevel >= 2) {
                          Get.to(Level2ApplicationsScreen(jobId: widget.jobId));
                        }
                      },
                      hasInfiniteWidth: true,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: maxLevel >= 3
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: maxLevel >= 3
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 3",
                      onPressed: () {
                        if (maxLevel >= 3) {
                          Get.to(Level3ApplicationsScreen(jobId: widget.jobId));
                        }
                      },
                      hasInfiniteWidth: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
