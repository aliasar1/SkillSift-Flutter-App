import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/quiz/views/score_screen.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/quiz_controller.dart';
import 'quiz_screen.dart';

class QuizStarterScreen extends StatefulWidget {
  const QuizStarterScreen(
      {super.key, required this.applicationId, required this.jobId});

  final String applicationId;
  final String jobId;

  @override
  State<QuizStarterScreen> createState() => _QuizStarterScreenState();
}

class _QuizStarterScreenState extends State<QuizStarterScreen> {
  bool isLoading = true;
  bool isApplied = false;
  final quizController = Get.put(QuizController());

  @override
  void initState() {
    super.initState();
    checkIsApplied();
  }

  Future<void> checkIsApplied() async {
    isApplied =
        await quizController.checkIfApplicationExists(widget.applicationId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isLoading
        ? const Scaffold(
            body: Center(
              child: SpinKitHourGlass(
                color: LightTheme.primaryColor,
                size: 50.0,
              ),
            ),
          )
        : isApplied
            ? ScoreScreen(
                controller: quizController,
                applicationId: widget.applicationId,
                isApplied: isApplied,
                jobId: widget.jobId,
              )
            : Scaffold(
                backgroundColor: isDarkMode
                    ? DarkTheme.backgroundColor
                    : LightTheme.whiteShade2,
                appBar: AppBar(
                  backgroundColor: isDarkMode
                      ? DarkTheme.backgroundColor
                      : LightTheme.whiteShade2,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: isDarkMode
                          ? DarkTheme.whiteGreyColor
                          : LightTheme.black),
                  title: Txt(
                    title: "Quiz Rules",
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
                          color: LightTheme.primaryColor.withOpacity(0.8),
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
                      Txt(
                        title:
                            "Here are few rules to keep in mind before attempting the Quiz:",
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
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
                        height: 6,
                      ),
                      buildRule(
                          "1. Ensure you have active internet connection."),
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
                          quizController.getListOfRandomQuestions(
                              10, "information_technology");
                          Get.to(QuizScreen(
                            applicationId: widget.applicationId,
                            quizController: quizController,
                            jobId: widget.jobId,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Txt(
      title: text,
      textAlign: TextAlign.start,
      fontContainerWidth: double.infinity,
      textStyle: TextStyle(
        fontFamily: "Poppins",
        color:
            isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.secondaryColor,
        fontSize: Sizes.TEXT_SIZE_12,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
