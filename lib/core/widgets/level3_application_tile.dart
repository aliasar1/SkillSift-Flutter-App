import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';

import '../../app/jobs/controllers/job_level3_controller.dart';
import '../constants/theme/light_theme.dart';
import '../models/application_model.dart';
import '../models/jobseeker_model.dart';
import 'custom_text.dart';

class Level3ApplicationTile extends StatelessWidget {
  const Level3ApplicationTile({
    super.key,
    required this.jobseeker,
    required this.application,
    required this.jobLevel2Controller,
    required this.level3,
  });

  final JobSeeker jobseeker;
  final Application application;
  final JobLevel3Controller jobLevel2Controller;
  final CaseStudySession level3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Get.to(Applicant2DetailsScreen(
          //   jobseeker: jobseeker,
          //   initialApplication: application,
          //   level2: level3,
          //   jobLevel2Controller: jobLevel2Controller,
          // ));
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
                          // await jobLevel2Controller.updateJobStatus(
                          //     application.id!, "pending", lvl.toString());
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
                          // await jobLevel2Controller.updateJobStatus(
                          //     application.id!,
                          //     "rejected",
                          //     application.currentLevel);
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
