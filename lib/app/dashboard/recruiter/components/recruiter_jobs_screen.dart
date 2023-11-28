import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/recruiter/components/add_jobs_screen.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../controllers/jobs_controller.dart';

class RecruiterJobsScreen extends StatelessWidget {
  RecruiterJobsScreen({super.key});

  final jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.primaryColor,
          iconTheme: const IconThemeData(color: LightTheme.white),
          title: const Txt(
            title: "Manage Jobs",
            fontContainerWidth: double.infinity,
            textAlign: TextAlign.start,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Obx(() {
          if (jobController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: LightTheme.primaryColor,
              ),
            );
          } else if (jobController.jobList.isEmpty) {
            return const Center(
              child: Text('No jobs added'),
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(
                vertical: Sizes.MARGIN_12,
                horizontal: Sizes.MARGIN_8,
              ),
              child: ListView.builder(
                itemCount: jobController.jobList.length,
                itemBuilder: (context, index) {
                  final job = jobController.jobList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            jobController.deleteJob(job.jobId);
                          },
                          icon: const Icon(Icons.delete)),
                      title: Text(job.jobTitle),
                      subtitle: Text(job.mode),
                      trailing: IconButton(
                          onPressed: () {
                            Get.to(AddJobScreen(
                              isEdit: true,
                              job: job,
                            ));
                          },
                          icon: const Icon(Icons.edit)),
                    ),
                  );
                },
              ),
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddJobScreen(
              isEdit: false,
            ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.person_add,
            color: LightTheme.white,
          ),
        ),
      ),
    );
  }
}
