import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/widgets/recruiter_drawer.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../../company/controllers/company_profile_controller.dart';
import '../components/add_jobs_screen.dart';
import '../controllers/jobs_controller.dart';

class RecruiterDashboard extends StatelessWidget {
  RecruiterDashboard({super.key});

  final authController = Get.put(AuthController());
  final profileController = Get.put(ProfileController());
  final jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        drawer: RecruiterDrawer(
          authController: authController,
          profileController: profileController,
        ),
        appBar: AppBar(),
        body: Column(
          children: [
            Obx(
              () {
                if (profileController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.whiteShade2,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Sizes.MARGIN_16),
                        child: Column(
                          children: [
                            Txt(
                              textAlign: TextAlign.start,
                              title:
                                  'Hello ${profileController.user['fullName']}!',
                              fontContainerWidth: double.infinity,
                              textStyle: const TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.secondaryColor,
                                fontSize: Sizes.TEXT_SIZE_22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Sizes.HEIGHT_10),
                            const Txt(
                              textAlign: TextAlign.start,
                              title: "Welcome To Recruiter Dashboard",
                              fontContainerWidth: double.infinity,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.primaryColor,
                                fontSize: Sizes.TEXT_SIZE_16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Sizes.HEIGHT_18),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Obx(() {
              if (jobController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.primaryColor,
                    ),
                  ),
                );
              } else if (jobController.jobList.isEmpty) {
                return Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.NO_JOB_ADDED,
                          height: Sizes.ICON_SIZE_50 * 4,
                          width: Sizes.ICON_SIZE_50 * 4,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Txt(
                            title: "No jobs are added yet!",
                            fontContainerWidth: double.infinity,
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.secondaryColor,
                              fontSize: Sizes.TEXT_SIZE_16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.HEIGHT_160),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                  child: Column(
                    children: [
                      const CustomSearchWidget(
                        label: 'Search added jobs here...',
                      ),
                      const SizedBox(height: Sizes.HEIGHT_16),
                      ListView.builder(
                        itemCount: jobController.jobList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final job = jobController.jobList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: ListTile(
                              tileColor: LightTheme.greyShade1,
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
                                      jobController: jobController,
                                    ));
                                  },
                                  icon: const Icon(Icons.edit)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            jobController.clearFields();
            Get.to(AddJobScreen(
              isEdit: false,
              jobController: jobController,
            ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.post_add,
            color: LightTheme.white,
          ),
        ),
      ),
    );
  }
}
