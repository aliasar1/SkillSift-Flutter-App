import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/app/jobs/controllers/job_level2_controller.dart';
import 'package:skillsift_flutter_app/core/models/level2_model.dart';
import 'package:skillsift_flutter_app/core/services/level2_api.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/services/job_api.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/level2_application_tile.dart';

class Level2ApplicationsScreen extends StatefulWidget {
  const Level2ApplicationsScreen({super.key, required this.jobId});

  final String jobId;

  @override
  State<Level2ApplicationsScreen> createState() =>
      _Level2ApplicationsScreenState();
}

class _Level2ApplicationsScreenState extends State<Level2ApplicationsScreen> {
  final jobLevel2Controller = Get.put(JobLevel2Controller());
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    loadApplications();
  }

  Future<void> loadApplications() async {
    isLoading = true;
    jobLevel2Controller.applications.clear();
    jobLevel2Controller.jobSeekers.clear();
    await jobLevel2Controller.getApplications(widget.jobId);
    for (int i = 0; i < jobLevel2Controller.applications.length; i++) {
      if (jobLevel2Controller.applications[i].currentLevel == "2" ||
          jobLevel2Controller.applications[i].currentLevel == "3") {
        var data = await Level2Api.getScoreByApplicationId(
            jobLevel2Controller.applications[i].id!);
        level2s.add(data);
      }
    }

    if (jobLevel2Controller.isSortApplied.value) {
      jobLevel2Controller.applications.sort((a, b) {
        final scoreA = (level2s
                .firstWhere(
                  (element) => element!.applicationId == a.id,
                  orElse: () => null,
                )
                ?.score ??
            0);

        final scoreB = (level2s
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

  List<Level2?> level2s = [];

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
                jobLevel2Controller.toggleSort();
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
          title: "Level 2 Applications",
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
        return jobLevel2Controller.isLoading.value && isLoading
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
                itemCount: jobLevel2Controller.applications.length,
                itemBuilder: (context, index) {
                  final jobseeker = jobLevel2Controller.jobSeekers.firstWhere(
                    (seeker) =>
                        seeker.id ==
                        jobLevel2Controller.applications[index].jobseekerId,
                  );
                  final application = jobLevel2Controller.applications[index];
                  final level = level2s.firstWhere(
                    (element) => element?.applicationId == application.id,
                    orElse: () => null,
                  );
                  return Level2ApplicationTile(
                    jobseeker: jobseeker,
                    application: application,
                    jobLevel2Controller: jobLevel2Controller,
                    level2: level!,
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
                        totalCount: jobLevel2Controller.applications.length,
                        initValue: jobLevel2Controller.applications.length / 2,
                        unSelectedNumberStyle: TextStyle(
                          fontSize: 14.0,
                          color: isDarkMode ? Colors.grey : Colors.grey,
                        ),
                        currentIndex: jobLevel2Controller.initialCount.value,
                        onValueChanged: (val) {
                          jobLevel2Controller.initialCount.value = val;
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
                      if (jobLevel2Controller.isSortApplied.value) {
                        int top = jobLevel2Controller.initialCount.value;
                        List<Application> applications =
                            jobLevel2Controller.applications;
                        top = top.clamp(0, applications.length);

                        for (int i = 0; i < top; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "2") {
                            int lvl = int.parse(application.currentLevel);
                            lvl++;
                            await jobLevel2Controller.updateJobStatus(
                              application.id!,
                              "accepted",
                              lvl.toString(),
                              application.jobseekerId,
                              application.jobId,
                            );
                          }
                        }

                        for (int i = top; i < applications.length; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "2") {
                            await jobLevel2Controller.updateJobStatus(
                              application.id!,
                              "rejected",
                              application.currentLevel,
                              application.jobseekerId,
                              application.jobId,
                            );
                          }
                        }
                      } else {
                        jobLevel2Controller.toggleSort();
                        await loadApplications();
                        int top = jobLevel2Controller.initialCount.value;
                        List<Application> applications =
                            jobLevel2Controller.applications;
                        top = top.clamp(0, applications.length);

                        for (int i = 0; i < top; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "2") {
                            int lvl = int.parse(application.currentLevel);
                            lvl++;
                            await jobLevel2Controller.updateJobStatus(
                              application.id!,
                              "accepted",
                              lvl.toString(),
                              application.jobseekerId,
                              application.jobId,
                            );
                          }
                        }

                        for (int i = top; i < applications.length; i++) {
                          Application application = applications[i];
                          if (application.applicationStatus == 'pending' &&
                              application.currentLevel == "2") {
                            await jobLevel2Controller.updateJobStatus(
                              application.id!,
                              "rejected",
                              application.currentLevel,
                              application.jobseekerId,
                              application.jobId,
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
