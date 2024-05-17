import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/case_study_session_model.dart';
import '../../../core/services/case_study_session_api.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/level3_application_tile.dart';
import '../controllers/job_level3_controller.dart';

class Level3ApplicationsScreen extends StatefulWidget {
  const Level3ApplicationsScreen({super.key, required this.jobId});

  final String jobId;

  @override
  State<Level3ApplicationsScreen> createState() =>
      _Level3ApplicationsScreenState();
}

class _Level3ApplicationsScreenState extends State<Level3ApplicationsScreen> {
  final level3JobController = Get.put(JobLevel3Controller());
  List<CaseStudySession?> level3s = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    loadApplications();
  }

  Future<void> loadApplications() async {
    isLoading = true;
    await level3JobController.getApplications(widget.jobId);
    for (int i = 0; i < level3JobController.applications.length; i++) {
      if (level3JobController.applications[i].currentLevel == "3") {
        var data = await CaseStudySessionService.getScoreByApplicationId(
            level3JobController.applications[i].id!);
        level3s.add(data);
      }
    }

    if (level3JobController.isSortApplied.value) {
      level3JobController.applications.sort((a, b) {
        final scoreA = (level3s
                .firstWhere(
                  (element) => element!.applicationId == a.id,
                  orElse: () => null,
                )
                ?.score ??
            0);

        final scoreB = (level3s
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        actions: [
          IconButton(
              onPressed: () async {
                level3JobController.toggleSort();
                await loadApplications();
              },
              icon: const Icon(Icons.swap_vert)),
          IconButton(
              onPressed: () {
                buildAutoAcceptSheet(context);
              },
              icon: const Icon(Icons.sort))
        ],
        title: const Txt(
          title: "Level 3 Applications",
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
      body: Obx(() {
        return level3JobController.isLoading.value && isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.white,
                        ),
                        title: Container(
                          height: 10,
                          color: Colors.white,
                        ),
                        subtitle: Container(
                          height: 10,
                          color: Colors.white,
                        ),
                        trailing: Container(
                          width: 50,
                          height: 50,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              )
            : ListView.builder(
                itemCount: level3JobController.applications.length,
                itemBuilder: (context, index) {
                  final jobseeker = level3JobController.jobSeekers.firstWhere(
                    (seeker) =>
                        seeker.id ==
                        level3JobController.applications[index].jobseekerId,
                  );
                  final application = level3JobController.applications[index];
                  final level = level3s.firstWhere(
                    (element) => element?.applicationId == application.id,
                    orElse: () => null,
                  );
                  return Level3ApplicationTile(
                    jobseeker: jobseeker,
                    application: application,
                    jobLevel3Controller: level3JobController,
                    level3: level!,
                  );
                });
      }),
    );
  }

  Future<dynamic> buildAutoAcceptSheet(BuildContext context) {
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
              decoration: const BoxDecoration(
                color: LightTheme.whiteShade2,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Txt(
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        title: 'Automatically Accept',
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Txt(
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        title:
                            'Select the number of top rated candidates you want to accept, the remaining ones will be automatically rejected. Your current job will automatically be marked as not accepting more CVs and this action cannot be undone.',
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Center(
                      child: WheelSlider.number(
                        isInfinite: false,
                        totalCount: level3JobController.applications.length,
                        initValue: level3JobController.applications.length / 2,
                        unSelectedNumberStyle: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                        ),
                        currentIndex: level3JobController.initialCount.value,
                        onValueChanged: (val) {
                          level3JobController.initialCount.value = val;
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
                      // if (jobLevel2Controller.isSortApplied.value) {
                      //   int top = jobLevel2Controller.initialCount.value;
                      //   List<Application> applications =
                      //       jobLevel2Controller.applications;
                      //   top = top.clamp(0, applications.length);

                      //   for (int i = 0; i < top; i++) {
                      //     Application application = applications[i];
                      //     if (application.applicationStatus == 'pending' &&
                      //         application.currentLevel == "2") {
                      //       int lvl = int.parse(application.currentLevel);
                      //       lvl++;
                      //       await jobLevel2Controller.updateJobStatus(
                      //           application.id!, "accepted", lvl.toString());
                      //     }
                      //   }

                      //   for (int i = top; i < applications.length; i++) {
                      //     Application application = applications[i];
                      //     if (application.applicationStatus == 'pending' &&
                      //         application.currentLevel == "2") {
                      //       await jobLevel2Controller.updateJobStatus(
                      //           application.id!,
                      //           "rejected",
                      //           application.currentLevel);
                      //     }
                      //   }
                      // } else {
                      //   jobLevel2Controller.toggleSort();
                      //   await loadApplications();
                      //   int top = jobLevel2Controller.initialCount.value;
                      //   List<Application> applications =
                      //       jobLevel2Controller.applications;
                      //   top = top.clamp(0, applications.length);

                      //   for (int i = 0; i < top; i++) {
                      //     Application application = applications[i];
                      //     if (application.applicationStatus == 'pending' &&
                      //         application.currentLevel == "2") {
                      //       int lvl = int.parse(application.currentLevel);
                      //       lvl++;
                      //       await jobLevel2Controller.updateJobStatus(
                      //           application.id!, "accepted", lvl.toString());
                      //     }
                      //   }

                      //   for (int i = top; i < applications.length; i++) {
                      //     Application application = applications[i];
                      //     if (application.applicationStatus == 'pending' &&
                      //         application.currentLevel == "2") {
                      //       await jobLevel2Controller.updateJobStatus(
                      //           application.id!,
                      //           "rejected",
                      //           application.currentLevel);
                      //     }
                      //   }
                      // }
                      // await JobApi.updateJobStatus(widget.jobId, "pending");
                      // Get.back();
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
