import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/case_base_qna/controllers/case_study_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/case_study_dataset.dart';

class CaseStudyQuestionScreen extends StatefulWidget {
  const CaseStudyQuestionScreen(
      {super.key, required this.applicationId, required this.controller});

  final String applicationId;
  final CaseStudyController controller;

  @override
  State<CaseStudyQuestionScreen> createState() =>
      _CaseStudyQuestionScreenState();
}

class _CaseStudyQuestionScreenState extends State<CaseStudyQuestionScreen> {
  var question = {};
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await widget.controller.calculateRemainingTime(widget.applicationId);
    int time = widget.controller.remainingTime.value;
    Random random = Random();

    int randomNumber = random.nextInt(10);
    print(randomNumber);
    question = caseStudyDifficultQuestions[randomNumber];
    print(question);
    if (time <= 0) {
      // timesup
    } else {
      await widget.controller.addStartTime(widget.applicationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Obx(
          () => widget.controller.isLoading.value
              ? const Center(
                  child: SpinKitCubeGrid(
                    color: LightTheme.primaryColor,
                    size: 50.0,
                  ),
                )
              : ListView(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      question['question'],
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
                    CustomTextFormField(
                      controller: widget.controller.studyAnsController,
                      maxLines: 10,
                      maxLength: 2000,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonType: ButtonType.outline,
                            textColor: LightTheme.black,
                            color: LightTheme.primaryColor,
                            text: "Save Progress",
                            onPressed: () {},
                            hasInfiniteWidth: true,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: CustomButton(
                            buttonType: ButtonType.text,
                            textColor: LightTheme.white,
                            color: LightTheme.primaryColor,
                            text: "Submit",
                            onPressed: () {},
                            hasInfiniteWidth: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
