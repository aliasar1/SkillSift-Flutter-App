import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';
import 'package:skillsift_flutter_app/core/widgets/custom_text.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';

class ReviewResponseScreen extends StatelessWidget {
  const ReviewResponseScreen({super.key, required this.session});

  final CaseStudySession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor: LightTheme.whiteShade2,
        elevation: 0,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Case Study Response",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
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
              Text(
                session.question,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                session.response,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
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
