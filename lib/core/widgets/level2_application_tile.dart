import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/jobs/controllers/job_level2_controller.dart';
import '../../app/jobs/views/application2_details_screen.dart';
import '../constants/theme/dark_theme.dart';
import '../constants/theme/light_theme.dart';
import '../helpers/circle_avatart_profile_builder.dart';
import '../models/application_model.dart';
import '../models/jobseeker_model.dart';
import '../models/level2_model.dart';
import 'custom_text.dart';

class Level2ApplicationTile extends StatelessWidget {
  const Level2ApplicationTile({
    super.key,
    required this.jobseeker,
    required this.application,
    required this.jobLevel2Controller,
    required this.level2,
  });

  final JobSeeker jobseeker;
  final Application application;
  final JobLevel2Controller jobLevel2Controller;
  final Level2 level2;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(Applicant2DetailsScreen(
            jobseeker: jobseeker,
            initialApplication: application,
            level2: level2,
            jobLevel2Controller: jobLevel2Controller,
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
              title: "Quiz Rating: ${(level2.score * 10)}%",
            ),
          ),
          trailing: (application.currentLevel == "2" &&
                  application.applicationStatus == "pending")
              ? SizedBox(
                  width: Get.width * 0.3,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          int lvl = int.parse(application.currentLevel);
                          lvl++;
                          await jobLevel2Controller.updateJobStatus(
                            application.id!,
                            "pending",
                            lvl.toString(),
                            application.jobseekerId,
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
                          await jobLevel2Controller.updateJobStatus(
                            application.id!,
                            "rejected",
                            application.currentLevel,
                            application.jobseekerId,
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
