import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';

import '../../app/jobs/controllers/job_level_controller.dart';
import '../../app/jobs/views/applicant_details_screen.dart';
import '../constants/theme/light_theme.dart';
import '../helpers/circle_avatart_profile_builder.dart';
import '../models/application_model.dart';
import '../models/jobseeker_model.dart';
import '../models/level1_model.dart';
import 'custom_text.dart';

class CurrentApplicationTile extends StatelessWidget {
  const CurrentApplicationTile({
    super.key,
    required this.jobseeker,
    required this.application,
    required this.jobLevelController,
    required this.level1,
    required this.jobTitle,
    required this.jobseekerId,
  });

  final JobSeeker jobseeker;
  final Application application;
  final JobLevelController jobLevelController;
  final Level1 level1;
  final String jobseekerId;
  final String jobTitle;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(ApplicantDetailsScreen(
            jobseeker: jobseeker,
            initialApplication: application,
            level1: level1,
            jobLevelController: jobLevelController,
            jobTitle: jobTitle,
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
              title: "CV Rating: ${level1.score}%",
            ),
          ),
          trailing: (application.currentLevel == "1" &&
                  application.applicationStatus == "pending")
              ? SizedBox(
                  width: Get.width * 0.3,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          int lvl = int.parse(application.currentLevel);
                          lvl++;
                          await jobLevelController.updateJobStatus(
                            application.id!,
                            "accepted",
                            lvl.toString(),
                            jobseekerId,
                            jobTitle,
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
                          await jobLevelController.updateJobStatus(
                            application.id!,
                            "rejected",
                            application.currentLevel,
                            jobseekerId,
                            jobTitle,
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
