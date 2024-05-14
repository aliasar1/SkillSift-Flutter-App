import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/case_study_session_model.dart';
import '../components/review_response_screen.dart';

class CaseStudyScoreScreen extends StatelessWidget {
  const CaseStudyScoreScreen({super.key, required this.session});

  final CaseStudySession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
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
              const Txt(
                title: 'Case Study Submitted!',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Txt(
                title:
                    'You will be notified about your further proceedings after recruiters reviews your response.',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 10),
              const Txt(
                title: 'Good Luck!',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
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
                    session: session,
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
