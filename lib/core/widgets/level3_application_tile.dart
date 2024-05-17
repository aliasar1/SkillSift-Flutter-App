import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';

import '../../app/jobs/controllers/job_level3_controller.dart';
import '../../app/jobs/views/application3_details_screen.dart';
import '../constants/theme/light_theme.dart';
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
  });

  final JobSeeker jobseeker;
  final Application application;
  final JobLevel3Controller jobLevel3Controller;
  final CaseStudySession level3;

  bool isStatusUpdated = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(Applicant3DetailsScreen(
            jobseeker: jobseeker,
            initialApplication: application,
            level3: level3,
            jobLevel3Controller: jobLevel3Controller,
          ));
        },
        child: ListTile(
          tileColor: LightTheme.cardLightShade,
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: SizedBox(
            width: Get.width * 0.5,
            child: Txt(
              textAlign: TextAlign.start,
              title: jobseeker.fullname,
            ),
          ),
          subtitle: SizedBox(
            width: Get.width * 0.5,
            child: Txt(
              textAlign: TextAlign.start,
              title: "Speed Efficiency: ${level3.score!.toStringAsFixed(2)}%",
            ),
          ),
          trailing: (application.currentLevel == "3" &&
                  application.applicationStatus == "pending")
              ? SizedBox(
                  width: Get.width * 0.25,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await jobLevel3Controller.updateJobStatus(
                            application.id!,
                            "accepted",
                            application.currentLevel,
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
                              application.currentLevel);
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
