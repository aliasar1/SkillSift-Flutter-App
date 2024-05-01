import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skillsift_flutter_app/app/quiz/controllers/quiz_controller.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:skillsift_flutter_app/app/quiz/views/score_screen.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_text.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key, required this.quizController}) : super(key: key);

  final QuizController quizController;

  @override
  Widget build(BuildContext context) {
    quizController.startTimer();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        body: Obx(
          () {
            if (quizController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
              );
            } else {
              if (quizController.index.value <
                  quizController.questionsData.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Sizes.MARGIN_12,
                    vertical: Sizes.MARGIN_12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Obx(
                        () => FAProgressBar(
                          currentValue:
                              10 - quizController.secondsRemaining.value,
                          size: 40,
                          maxValue: 10,
                          changeColorValue: 7,
                          changeProgressColor:
                              Colors.redAccent.withOpacity(0.7),
                          backgroundColor: LightTheme.primaryColorLightestShade,
                          progressColor: LightTheme.primaryColor,
                          animatedDuration: const Duration(milliseconds: 1500),
                          direction: Axis.horizontal,
                          displayText: ' Seconds',
                          formatValueFixed: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Txt(
                        title: quizController
                            .questionsData[quizController.index.value].question,
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        textStyle: const TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        4,
                        (index) {
                          final selectedAnswerIndex =
                              quizController.selectedAnswerIndex.value;

                          final isSelected = selectedAnswerIndex == index;

                          return GestureDetector(
                            onTap: () {
                              quizController.setSelectedAnswerIndex(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: isSelected
                                        ? LightTheme.primaryColorLightShade
                                        : Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                                color: isSelected
                                    ? LightTheme.primaryColorLightShade
                                        .withOpacity(0.1)
                                    : Colors.transparent,
                              ),
                              child: Txt(
                                title: quizController
                                    .questionsData[quizController.index.value]
                                    .choices[index],
                                textAlign: TextAlign.start,
                                fontContainerWidth: double.infinity,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: isSelected
                                      ? LightTheme.primaryColorLightShade
                                      : LightTheme.secondaryColor,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (quizController.selectedAnswerIndex.value == -1 &&
                              quizController.secondsRemaining.value > 0.0) {
                            Fluttertoast.showToast(
                                msg: "Please select an option.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            if (quizController.secondsRemaining.value == 0.0) {
                              quizController.checkAnswer(
                                  -1,
                                  quizController
                                      .questionsData[quizController.index.value]
                                      .answer);
                              quizController.updateIndex();
                            } else {
                              quizController.checkAnswer(
                                  quizController.selectedAnswerIndex.value,
                                  quizController
                                      .questionsData[quizController.index.value]
                                      .answer);
                              quizController.updateIndex();
                            }
                          }
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
                            width: 170,
                            height: 50,
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Txt(
                                  title: 'Next',
                                  textStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                int correct = quizController.correctAns.value;
                quizController.clearFields();
                quizController.resetTimer();
                return ScoreScreen(
                  score: correct,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
