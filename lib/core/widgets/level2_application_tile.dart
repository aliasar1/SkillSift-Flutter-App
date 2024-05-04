import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/jobs/controllers/job_level2_controller.dart';
import '../../app/jobs/views/application2_details_screen.dart';
import '../constants/theme/light_theme.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              title: "Quiz Rating: ${(level2.score * 100) / 10}%",
            ),
          ),
          trailing: (application.currentLevel == "2" &&
                  application.applicationStatus == "pending")
              ? SizedBox(
                  width: Get.width * 0.25,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          int lvl = int.parse(application.currentLevel);
                          lvl++;
                          await jobLevel2Controller.updateJobStatus(
                              application.id!, "pending", lvl.toString());
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
