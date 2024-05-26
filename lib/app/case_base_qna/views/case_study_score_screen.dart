import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/case_study_session_model.dart';
import '../components/review_response_screen.dart';

class CaseStudyScoreScreen extends StatefulWidget {
  const CaseStudyScoreScreen({super.key, required this.session});

  final CaseStudySession session;

  @override
  State<CaseStudyScoreScreen> createState() => _CaseStudyScoreScreenState();
}

class _CaseStudyScoreScreenState extends State<CaseStudyScoreScreen> {
  String? formattedTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    DateTime timestamp1 = widget.session.startTime;
    DateTime timestamp2 = widget.session.submissionTime!;

    Duration difference = timestamp2.difference(timestamp1);

    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    String time =
        '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    formattedTime = time;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: LightTheme.primaryColor,
                size: 100,
              ),
              const SizedBox(height: 20),
              Txt(
                title: 'Case Study Submitted!',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Txt(
                title: 'You took',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Txt(
                title: formattedTime!,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Txt(
                title: 'time to complete the given case study.',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 30),
              Txt(
                title:
                    'You will be notified about your further proceedings after recruiters reviews your response.',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              Txt(
                title: 'Good Luck!',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                buttonType: ButtonType.outline,
                textColor: LightTheme.primaryColor,
                color: LightTheme.primaryColor,
                text: "Review Your Response",
                onPressed: () {
                  Get.to(ReviewResponseScreen(
                    session: widget.session,
                  ));
                },
                hasInfiniteWidth: true,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LightTheme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        const SizedBox(width: 8),
                        Txt(
                          title: 'Go back to dashboard',
                          fontContainerWidth: Get.width * 0.8,
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
