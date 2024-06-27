import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';

import '../../app/jobs/controllers/job_level3_controller.dart';
import '../../app/jobs/views/application3_details_screen.dart';
import '../constants/theme/dark_theme.dart';
import '../constants/theme/light_theme.dart';
import '../helpers/circle_avatart_profile_builder.dart';
import '../models/application_model.dart';
import '../models/jobseeker_model.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class Level3ApplicationTile extends StatelessWidget {
  Level3ApplicationTile({
    super.key,
    required this.jobseeker,
    required this.application,
    required this.jobLevel3Controller,
    required this.level3,
    required this.jobName,
  });

  final JobSeeker jobseeker;
  final Application application;
  final JobLevel3Controller jobLevel3Controller;
  final CaseStudySession level3;
  final String jobName;

  bool isStatusUpdated = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(Applicant3DetailsScreen(
            jobseeker: jobseeker,
            initialApplication: application,
            level3: level3,
            jobLevel3Controller: jobLevel3Controller,
            jobName: jobName,
          ));
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(4),
          tileColor: isDarkMode
              ? DarkTheme.cardBackgroundColor
              : LightTheme.cardLightShade,
          leading: buildCircularAvatar(jobseeker.profilePicUrl, 36),
          title: SizedBox(
            child: Txt(
              textAlign: TextAlign.start,
              title: jobseeker.fullname,
            ),
          ),
          subtitle: SizedBox(
            child: Txt(
              textAlign: TextAlign.start,
              title: "Speed Efficiency: ${level3.score!.toStringAsFixed(2)}%",
            ),
          ),
          trailing: (application.currentLevel == "3" &&
                  application.applicationStatus == "pending")
              ? SizedBox(
                  width: Get.width * 0.3,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await jobLevel3Controller.updateJobStatus(
                            application.id!,
                            "accepted",
                            application.currentLevel,
                            application.jobId,
                          );
                        },
                        icon: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await jobLevel3Controller.updateJobStatus(
                            application.id!,
                            "rejected",
                            application.currentLevel,
                            application.jobId,
                          );
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              : application.applicationStatus == 'rejected'
                  ? const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    )
                  : const Icon(
                      Icons.check_box,
                      color: Colors.green,
                      size: 30,
                    ),
        ),
      ),
    );
  }
}
