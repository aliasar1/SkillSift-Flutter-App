import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';
import 'package:skillsift_flutter_app/core/widgets/custom_text.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';

class ReviewResponseScreen extends StatelessWidget {
  const ReviewResponseScreen({super.key, required this.session});

  final CaseStudySession session;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        elevation: 0,
        iconTheme: IconThemeData(
            color: isDarkMode ? DarkTheme.primaryColor : LightTheme.black),
        title: Txt(
          title: "Case Study Response",
          textAlign: TextAlign.start,
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
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Column(
            children: [
              Txt(
                title: session.question,
                fontContainerWidth: double.infinity,
                textAlign: TextAlign.start,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Txt(
                title: session.response,
                fontContainerWidth: double.infinity,
                textAlign: TextAlign.start,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: isDarkMode
                      ? DarkTheme.whiteGreyColor
                      : LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
