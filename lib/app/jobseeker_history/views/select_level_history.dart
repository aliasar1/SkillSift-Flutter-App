import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/interview_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/interview_api.dart';
import '../../case_base_qna/views/case_base_screen.dart';
import '../../quiz/views/quiz_starter_screen.dart';
import 'level1_details_screen.dart';

class SelectHistoryLevelScreen extends StatefulWidget {
  const SelectHistoryLevelScreen({
    super.key,
    required this.jobId,
    required this.maxLevel,
    required this.application,
    required this.jobName,
  });

  final String jobId;
  final String jobName;
  final int maxLevel;
  final Application application;

  @override
  State<SelectHistoryLevelScreen> createState() =>
      _SelectHistoryLevelScreenState();
}

class _SelectHistoryLevelScreenState extends State<SelectHistoryLevelScreen>
    with CacheManager {
  late JobSeeker jobseeker;
  bool isLoading = true;
  bool isInterviewExist = false;
  final deadlineController = TextEditingController();
  final timeController = TextEditingController();
  DateTime? deadline;
  TimeOfDay? timeInterview;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    try {
      final response = await AuthApi.getCurrentUser(false, getId()!);
      jobseeker = JobSeeker.fromJson(response);
      await checkInterviewExists(widget.application.id!);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkInterviewExists(String appId) async {
    try {
      final data = await InterviewApi.checkInterviewExists(appId);
      if (data['exists'] == true) {
        isInterviewExist = true;
        final interview = InterviewSchedule.fromJson(data['interview']);
        deadline = interview.date;
        deadlineController.text =
            DateFormat('dd-MM-yyyy').format(interview.date);
        timeController.text = interview.time;
        Get.snackbar('Notice', 'Your interview is scheduled.');
      } else {
        isInterviewExist = false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to check interview: $e');
    }
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
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: LightTheme.primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_20,
                vertical: Sizes.MARGIN_20,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      isDarkMode ? AppAssets.APP_ICON_DARK : AppAssets.APP_ICON,
                      height: Sizes.ICON_SIZE_50 * 2.5,
                      width: Sizes.ICON_SIZE_50 * 2.5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Txt(
                      title: "Select the level, you want to see the history.",
                      textAlign: TextAlign.center,
                      fontContainerWidth: Get.width * 0.7,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: widget.maxLevel >= 1
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: widget.maxLevel >= 1
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 1",
                      onPressed: () {
                        Get.to(Level1DetailsScreen(
                          jobName: widget.jobName,
                          application: widget.application,
                          jobId: widget.jobId,
                          jobseeker: jobseeker,
                        ));
                      },
                      hasInfiniteWidth: true,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: widget.maxLevel >= 2
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: widget.maxLevel >= 2
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 2",
                      onPressed: () {
                        Get.to(QuizStarterScreen(
                          applicationId: widget.application.id!,
                          jobId: widget.application.jobId,
                        ));
                      },
                      hasInfiniteWidth: true,
                    ),
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: widget.maxLevel >= 3
                          ? LightTheme.white
                          : LightTheme.greyShade1,
                      color: widget.maxLevel >= 3
                          ? LightTheme.primaryColor
                          : LightTheme.greyShade6,
                      text: "Level 3",
                      onPressed: () {
                        Get.to(CaseBaseScreen(
                          applicationId: widget.application.id!,
                          application: widget.application,
                        ));
                      },
                      hasInfiniteWidth: true,
                    ),
                    if (isInterviewExist)
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: Txt(
                              title:
                                  "Interview scheduled for ${deadlineController.text} at ${timeController.text}.",
                              textAlign: TextAlign.center,
                              textOverflow: TextOverflow.ellipsis,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: isDarkMode
                                    ? DarkTheme.whiteGreyColor
                                    : LightTheme.black,
                                fontSize: Sizes.TEXT_SIZE_16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
