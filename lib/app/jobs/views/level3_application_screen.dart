import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/case_study_session_model.dart';
import '../../../core/services/case_study_session_api.dart';
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
    level3JobController.applications.clear();
    level3JobController.jobSeekers.clear();
    await level3JobController.getApplications(widget.jobId);
    for (int i = 0; i < level3JobController.applications.length; i++) {
      if (level3JobController.applications[i].currentLevel == "3") {
        bool sessionExists = await CaseStudySessionService.checkSessionExists(
            level3JobController.applications[i].id!);
        bool scoreExists = await CaseStudySessionService.checkScoreExists(
            level3JobController.applications[i].id!);

        if (sessionExists && scoreExists) {
          var data = await CaseStudySessionService.getScoreByApplicationId(
              level3JobController.applications[i].id!);
          level3s.add(data);
        }
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
                level3JobController.toggleSort();
                await loadApplications();
              },
              icon: const Icon(Icons.swap_vert)),
        ],
        title: Txt(
          title: "Level 3 Applications",
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
        return level3JobController.isLoading.value || isLoading
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
                ],
              ),
            ),
          );
        });
  }
}
