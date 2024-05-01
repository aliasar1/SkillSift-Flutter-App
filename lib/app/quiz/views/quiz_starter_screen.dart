import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/quiz_controller.dart';
import 'quiz_screen.dart';

class QuizStarterScreen extends StatelessWidget {
  QuizStarterScreen({super.key});

  final quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor: LightTheme.whiteShade2,
        elevation: 0,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Quiz Rules",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: LightTheme.primaryColorLightShade.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Txt(
                title:
                    "Conratulations on proceeding to Level 2 of recruitment.",
                textAlign: TextAlign.center,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.white,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Txt(
              title:
                  "Here are few rules to keep in mind before attempting the Quiz:",
              textAlign: TextAlign.start,
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            buildRule("1. Ensure you have active internet connection."),
            buildRule("2. No cheating allowed."),
            buildRule("3. Each question has 15 seconds to attempt."),
            buildRule("4. There are 10 questions in total."),
            buildRule(
                "5. Only 1 attempt is allowed. Once the quiz is started, you cannot go back."),
            const Spacer(),
            CustomButton(
              buttonType: ButtonType.outline,
              textColor: LightTheme.primaryColor,
              color: LightTheme.primaryColor,
              text: "Start Quiz",
              onPressed: () {
                Get.to(QuizScreen(
                  quizController: quizController,
                ));
              },
              hasInfiniteWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRule(String text) {
    return Txt(
      title: text,
      textAlign: TextAlign.start,
      fontContainerWidth: double.infinity,
      textStyle: const TextStyle(
        fontFamily: "Poppins",
        color: LightTheme.secondaryColor,
        fontSize: Sizes.TEXT_SIZE_12,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
