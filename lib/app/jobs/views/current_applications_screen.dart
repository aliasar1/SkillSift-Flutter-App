import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';
import 'package:skillsift_flutter_app/core/services/job_api.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/level1_model.dart';
import '../../../core/services/level1_api.dart';
import '../../../core/widgets/current_application_tile.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/job_level_controller.dart';

class CurrentApplicationScreen extends StatefulWidget {
  const CurrentApplicationScreen(
      {super.key, required this.jobId, required this.jobTitle});

  final String jobId;
  final String jobTitle;

  @override
  State<CurrentApplicationScreen> createState() =>
      _CurrentApplicationScreenState();
}

class _CurrentApplicationScreenState extends State<CurrentApplicationScreen> {
  final jobLevelController = Get.put(JobLevelController());
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    loadApplications();
  }

  Future<void> loadApplications() async {
    isLoading = true;
    await jobLevelController.getApplications(widget.jobId);

    for (int i = 0; i < jobLevelController.applications.length; i++) {
      var data = await Level1Api.getLevel1ByApplicationId(
          jobLevelController.applications[i].id!);
      level1s.add(data);
    }

    if (jobLevelController.isSortApplied.value) {
      jobLevelController.applications.sort((a, b) {
        final scoreA = (level1s
                .firstWhere(
                  (element) => element!.applicationId == a.id,
                  orElse: () => null,
                )
                ?.score ??
            0);

        final scoreB = (level1s
                .firstWhere(
                  (element) => element!.applicationId == b.id,
                  orElse: () => null,
                )
                ?.score ??
            0);

        return scoreB.compareTo(scoreA);
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  List<Level1?> level1s = [];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        iconTheme: IconThemeData(
            color: isDarkMode ? DarkTheme.whiteColor : LightTheme.black),
        actions: [
          IconButton(
              onPressed: () async {
                jobLevelController.toggleSort();
                await loadApplications();
              },
              icon: const Icon(Icons.swap_vert)),
          IconButton(
              onPressed: () {
                buildAutoAcceptSheet(context);
              },
              icon: const Icon(Icons.sort))
        ],
        title: Txt(
          title: "Applications",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color:
                isDarkMode ? DarkTheme.whiteColor : LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Obx(() {
        return jobLevelController.isLoading.value && isLoading
            ? Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.grey[900]! : Colors.grey[300]!,
                highlightColor:
                    isDarkMode ? Colors.grey[500]! : Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isDarkMode
                              ? DarkTheme.containerColor
                              : Colors.white,
                        ),
                        title: Container(
                          height: 10,
                          color: isDarkMode
                              ? DarkTheme.containerColor
                              : Colors.white,
                        ),
                        subtitle: Container(
                          height: 10,
                          color: isDarkMode
                              ? DarkTheme.containerColor
                              : Colors.white,
                        ),
                        trailing: Container(
                          width: 50,
                          height: 50,
                          color: isDarkMode
                              ? DarkTheme.containerColor
                              : Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              )
            : ListView.builder(
                itemCount: jobLevelController.applications.length,
                itemBuilder: (context, index) {
                  final jobseeker = jobLevelController.jobSeekers.firstWhere(
                    (seeker) =>
                        seeker.id ==
                        jobLevelController.applications[index].jobseekerId,
                  );
                  final application = jobLevelController.applications[index];
                  final level = level1s.firstWhere(
                    (element) => element?.applicationId == application.id,
                    orElse: () => null,
                  );
                  return CurrentApplicationTile(
                    jobseeker: jobseeker,
                    application: application,
                    jobLevelController: jobLevelController,
                    level1: level!,
                    jobseekerId: application.jobseekerId,
                    jobTitle: widget.jobTitle,
                  );
                });
      }),
    );
  }

  Future<dynamic> buildAutoAcceptSheet(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              height: Get.height * 0.42,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? DarkTheme.containerColor
                    : LightTheme.whiteShade2,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Txt(
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        title: 'Automatically Accept',
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Txt(
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        title:
                            'Select the number of top rated candidates you want to accept, the remaining ones will be automatically rejected. Your current job will automatically be marked as not accepting more CVs and this action cannot be undone.',
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Center(
                      child: WheelSlider.number(
                        selectedNumberStyle: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                        isInfinite: false,
                        totalCount: jobLevelController.applications.length,
                        initValue: jobLevelController.applications.length / 2,
                        unSelectedNumberStyle: TextStyle(
                          fontSize: 14.0,
                          color: isDarkMode ? Colors.grey : Colors.grey,
                        ),
                        currentIndex: jobLevelController.initialCount.value,
                        onValueChanged: (val) {
                          jobLevelController.initialCount.value = val;
                        },
                        hapticFeedbackType: HapticFeedbackType.heavyImpact,
                      ),
                    ),
                  ),
                  CustomButton(
                    buttonType: ButtonType.text,
                    textColor: LightTheme.white,
                    color: LightTheme.primaryColor,
                    text: "Filter",
                    onPressed: () async {
                      if (jobLevelController.isSortApplied.value) {
                        int top = jobLevelController.initialCount.value;
                        List<Application> applications =
                            jobLevelController.applications;
                        top = top.clamp(0, applications.length);

                        for (int i = 0; i < top; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "1") {
                            int lvl = int.parse(application.currentLevel);
                            lvl++;
                            await jobLevelController.updateJobStatus(
                              application.id!,
                              "accepted",
                              lvl.toString(),
                              application.jobseekerId,
                              widget.jobTitle,
                            );
                          }
                        }

                        for (int i = top; i < applications.length; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "1") {
                            await jobLevelController.updateJobStatus(
                              application.id!,
                              "rejected",
                              application.currentLevel,
                              application.jobseekerId,
                              widget.jobTitle,
                            );
                          }
                        }
                      } else {
                        jobLevelController.toggleSort();
                        await loadApplications();
                        int top = jobLevelController.initialCount.value;
                        List<Application> applications =
                            jobLevelController.applications;
                        top = top.clamp(0, applications.length);

                        for (int i = 0; i < top; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "1") {
                            int lvl = int.parse(application.currentLevel);
                            lvl++;
                            await jobLevelController.updateJobStatus(
                              application.id!,
                              "accepted",
                              lvl.toString(),
                              application.jobseekerId,
                              widget.jobTitle,
                            );
                          }
                        }

                        for (int i = top; i < applications.length; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "1") {
                            await jobLevelController.updateJobStatus(
                              application.id!,
                              "rejected",
                              application.currentLevel,
                              application.jobseekerId,
                              widget.jobTitle,
                            );
                          }
                        }
                      }
                      await JobApi.updateJobStatus(widget.jobId, "pending");
                      Get.back();
                    },
                    hasInfiniteWidth: true,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
