import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/app/case_base_qna/controllers/case_study_controller.dart';
import 'package:skillsift_flutter_app/app/case_base_qna/views/case_study_score_screen.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/case_study_dataset.dart';

class CaseStudyQuestionScreen extends StatefulWidget {
  const CaseStudyQuestionScreen(
      {super.key,
      required this.applicationId,
      required this.controller,
      required this.application});

  final String applicationId;
  final CaseStudyController controller;
  final Application application;

  @override
  State<CaseStudyQuestionScreen> createState() =>
      _CaseStudyQuestionScreenState();
}

class _CaseStudyQuestionScreenState extends State<CaseStudyQuestionScreen> {
  var question = {};
  late String? caseStudyQuestion;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    var controller = widget.controller;
    await controller.getData(widget.applicationId);
    if (controller.isSessionExist.value) {
      DateTime timestamp1 = controller.session!.startTime;
      DateTime timestamp2 = DateTime.now();

      String formattedStartTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(timestamp1.toUtc());

      String formattedCurrentTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(timestamp2.toUtc());

      Duration difference = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
          .parse(formattedCurrentTime)
          .difference(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
              .parse(formattedStartTime));

      Duration remainingTime = const Duration(hours: 2) - difference;

      controller.hours.value = remainingTime.inHours;
      controller.mins.value = remainingTime.inMinutes.remainder(60);
      controller.secs.value = remainingTime.inSeconds.remainder(60);

      caseStudyQuestion = controller.session!.question;

      controller.studyAnsController.text = controller.session!.response;

      _stopWatchTimer.setPresetHoursTime(controller.hours.value);
      _stopWatchTimer.setPresetMinuteTime(controller.mins.value);
      _stopWatchTimer.setPresetSecondTime(controller.secs.value);

      _stopWatchTimer.onStartTimer();
    } else {
      Random random = Random();
      int randomNumber = random.nextInt(10);
      question = caseStudyDifficultQuestions[randomNumber];

      await controller.addStartTime(widget.applicationId, question['question']);
      _stopWatchTimer.setPresetHoursTime(2);
      _stopWatchTimer.setPresetMinuteTime(0);
      _stopWatchTimer.setPresetSecondTime(0);
      _stopWatchTimer.onStartTimer();
    }
    setState(() {
      isLoading = false;
    });
  }

  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Obx(
            () => widget.controller.isLoading.value || isLoading
                ? const Center(
                    child: SpinKitCubeGrid(
                      color: LightTheme.primaryColor,
                      size: 50.0,
                    ),
                  )
                : ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data;
                          final displayTime =
                              StopWatchTimer.getDisplayTime(value!);
                          if (displayTime == "00:00:00.00") {
                            _saveProgress(widget.controller);
                          }
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  displayTime,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: LightTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.controller.isSessionExist.value
                            ? caseStudyQuestion
                            : question['question'],
                        style: TextStyle(
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
                              textColor: isDarkMode
                                  ? DarkTheme.whiteColor
                                  : LightTheme.black,
                              color: LightTheme.primaryColor,
                              text: "Save Progress",
                              onPressed: () async {
                                await widget.controller.saveProgress(
                                  widget.applicationId,
                                  widget.controller.isSessionExist.value
                                      ? caseStudyQuestion!
                                      : question['question']!,
                                  widget.controller.studyAnsController.text,
                                  "pending",
                                );
                              },
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
                              onPressed: () {
                                _saveProgress(widget.controller);
                              },
                              hasInfiniteWidth: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _saveProgress(CaseStudyController controller) async {
    DateTime timestamp1 = controller.session!.startTime;
    DateTime timestamp2 = DateTime.now();

    String formattedStartTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(timestamp1.toUtc());

    String formattedCurrentTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(timestamp2.toUtc());

    Duration difference = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
        .parse(formattedCurrentTime)
        .difference(
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(formattedStartTime));

    double efficiency = calculateEfficiency(difference);

    await widget.controller.submitResponse(
      widget.applicationId,
      widget.controller.isSessionExist.value
          ? caseStudyQuestion!
          : question['question']!,
      widget.controller.studyAnsController.text,
      "submitted",
      efficiency,
      widget.application.jobseekerId,
      widget.application.jobId,
    );

    Get.to(CaseStudyScoreScreen(session: widget.controller.session!));
  }

  double calculateEfficiency(Duration difference) {
    const int maxTimeMinutes = 120;
    double timeTakenMinutes =
        difference.inMinutes + (difference.inSeconds % 60) / 60.0;

    if (timeTakenMinutes <= 0) {
      return 100.0;
    } else if (timeTakenMinutes >= maxTimeMinutes) {
      return 0.0;
    } else {
      return (1 - (timeTakenMinutes / maxTimeMinutes)) * 100;
    }
  }
}
