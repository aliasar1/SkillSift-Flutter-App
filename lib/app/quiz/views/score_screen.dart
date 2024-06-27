import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/quiz/controllers/quiz_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({
    super.key,
    required this.controller,
    required this.applicationId,
    required this.isApplied,
    required this.jobId,
  });

  final QuizController controller;
  final String applicationId;
  final bool isApplied;
  final String jobId;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      if (widget.isApplied) {
        widget.controller.correctAns.value = await widget.controller
            .getScoreByApplicationId(widget.applicationId);
        await widget.controller.loadQuizSummary(widget.applicationId);
      } else {
        await widget.controller.addScore(
            widget.applicationId,
            widget.controller.correctAns.value,
            "pending",
            widget.applicationId,
            widget.jobId);
        await widget.controller.addQuizAttempt(widget.applicationId);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: isLoading
          ? const Center(
              child: SpinKitCubeGrid(
                color: LightTheme.primaryColor,
                size: 50.0,
              ),
            )
          : Container(
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
                      title: 'Quiz Completed!',
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
                      title: 'Your Score:',
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
                    const SizedBox(height: 10),
                    Txt(
                      title: '${widget.controller.correctAns}/10',
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
                    const SizedBox(height: 30),
                    Txt(
                      title:
                          'You will be notified about your further proceedings after recruiters reviews your Quiz.',
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
                      text: "Get Attempt Summary",
                      onPressed: () {
                        widget.controller.generateQuizSummaryPdf();
                      },
                      hasInfiniteWidth: true,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        widget.controller.clearAllFields();
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
                                fontContainerWidth: Get.width * 0.7,
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
