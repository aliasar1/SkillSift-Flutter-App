import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/core/models/application_model.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/case_study_controller.dart';
import 'case_study_question.dart';
import 'case_study_score_screen.dart';

class CaseBaseScreen extends StatefulWidget {
  const CaseBaseScreen(
      {super.key, required this.applicationId, required this.application});

  final String applicationId;
  final Application application;

  @override
  State<CaseBaseScreen> createState() => _CaseBaseScreenState();
}

class _CaseBaseScreenState extends State<CaseBaseScreen> {
  final caseStudyController = Get.put(CaseStudyController());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    var controller = caseStudyController;
    await controller.getData(widget.applicationId);
    if (controller.isSessionExist.value) {
      if (controller.session!.status == "submitted") {
        Get.off(CaseStudyScoreScreen(session: controller.session!));
      }
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

      if (remainingTime <= Duration.zero) {
        Get.off(CaseStudyScoreScreen(session: controller.session!));
      }

      controller.studyAnsController.text = controller.session!.response;
    }
    setState(() {
      isLoading = false;
    });
  }

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
            color: isDarkMode ? DarkTheme.whiteColor : LightTheme.black),
        title: Txt(
          title: "Case Based QnA Rules",
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
      body: isLoading
          ? const Center(
              child: SpinKitCubeGrid(
                color: LightTheme.primaryColor,
                size: 50.0,
              ),
            )
          : Padding(
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
                          "Congratulations on proceeding to Level 3 of recruitment.",
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
                        "Here are few rules to keep in mind before attempting the Case Based Study Questions:",
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
                  buildRule("1. Ensure you have active internet connection."),
                  buildRule("2. No cheating allowed."),
                  buildRule("3. You have total time of 2 hours."),
                  buildRule(
                      "4. Once you start the question your timer will be stared and if you close the app your time still will be running."),
                  buildRule("5. Only 1 attempt is allowed."),
                  const Spacer(),
                  CustomButton(
                    buttonType: ButtonType.outline,
                    textColor: LightTheme.primaryColor,
                    color: LightTheme.primaryColor,
                    text: "Start Case Study",
                    onPressed: () {
                      caseStudyController.clearFields();
                      Get.to(CaseStudyQuestionScreen(
                        applicationId: widget.applicationId,
                        controller: caseStudyController,
                        application: widget.application,
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
