import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import '../controllers/job_level_controller.dart';
import 'applicant_details_screen.dart';

class CurrentApplicationScreen extends StatefulWidget {
  const CurrentApplicationScreen({super.key, required this.jobId});

  final String jobId;

  @override
  State<CurrentApplicationScreen> createState() =>
      _CurrentApplicationScreenState();
}

class _CurrentApplicationScreenState extends State<CurrentApplicationScreen> {
  final jobLevelController = Get.put(JobLevelController());

  @override
  void initState() {
    super.initState();
    loadApplications();
  }

  Future<void> loadApplications() async {
    try {
      await jobLevelController.getApplications(widget.jobId);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Applications",
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
        return jobLevelController.isLoading.value
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
                itemCount: jobLevelController.applications.length,
                itemBuilder: (context, index) {
                  final jobseeker = jobLevelController.jobSeekers[index];
                  final application = jobLevelController.applications[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ApplicantDetailsScreen(
                          jobseeker: jobseeker,
                          application: application,
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
                          child: const Txt(
                            textAlign: TextAlign.start,
                            title: "CV Rating: ${22}%",
                          ),
                        ),
                        trailing: SizedBox(
                          width: Get.width * 0.25,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await jobLevelController.updateJobStatus(
                                      application.jobId, "Accepted", "2");
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
                                      application.jobId, "Rejected", "1");
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
      }),
    );
  }
}
