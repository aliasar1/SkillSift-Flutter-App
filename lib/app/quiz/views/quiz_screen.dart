import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key}) : super(key: key);

  final quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Quiz",
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
                        final correctAnswerIndex = quizController
                            .questionsData[quizController.index.value].answer;

                        final isSelected = selectedAnswerIndex == index;
                        final isCorrect = index == correctAnswerIndex;
                        final isGreen = isSelected && isCorrect;

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
                              // Access choices by index
                              title: quizController
                                  .questionsData[quizController.index.value]
                                  .choices[index],
                              textAlign: TextAlign.start,
                              fontContainerWidth: double.infinity,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: isGreen
                                    ? Colors.green
                                    : isSelected
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
                        quizController.updateIndex();
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
              // Handle when index goes out of bounds
              return const Center(
                child: Txt(
                  title: 'End of Quiz',
                  textAlign: TextAlign.center,
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
