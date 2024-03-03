import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/company_signup.dart';
import 'package:skillsift_flutter_app/app/jobs/controllers/job_controller.dart';
import 'package:skillsift_flutter_app/app/jobs/views/add_job_screen.dart';
import 'package:skillsift_flutter_app/app/jobs/views/job_details_screen.dart';
import 'package:skillsift_flutter_app/core/extensions/helper_extensions.dart';
import 'package:skillsift_flutter_app/core/widgets/templates/no_jobs_added.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/job_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/widgets/recruiter_drawer.dart';
import '../../authentication/controllers/auth_controller.dart';

class RecruiterDashboard extends StatefulWidget {
  const RecruiterDashboard({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  final controller = Get.put(AuthController());
  final jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
          actions: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: LightTheme.grey,
                  backgroundImage: widget.recruiter.profilePicUrl == ""
                      ? const NetworkImage(
                          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
                      : NetworkImage(
                          widget.recruiter.profilePicUrl,
                        ),
                  radius: 25,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      widget.recruiter.companyId == null
                          ? Icons.warning
                          : Icons.check_circle,
                      color: widget.recruiter.companyId == null
                          ? Colors.red
                          : Colors.green,
                      size: 22,
                    )),
              ],
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
          ],
        ),
        drawer: RecruiterDrawer(
            recruiter: widget.recruiter, controller: controller),
        body: widget.recruiter.companyId == null &&
                (controller.getSkipFlag() == null || !controller.getSkipFlag()!)
            ? Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: LightTheme.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: LightTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: const Icon(Icons.warning,
                            color: Colors.white, size: 100),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_24),
                      const Txt(
                        title: "Account Activation Required",
                        textAlign: TextAlign.center,
                        fontContainerWidth: 260,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_18),
                      const Txt(
                        title:
                            "Please complete your company details in order to activate your account.",
                        textAlign: TextAlign.center,
                        fontContainerWidth: 280,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.setSkipFlag(true);
                              setState(() {});
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(LightTheme.white),
                              foregroundColor: MaterialStateProperty.all(
                                  LightTheme.primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            child: const Text('Skip'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(CompanySignupScreen(
                                recruiter: widget.recruiter,
                              ));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  LightTheme.primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(LightTheme.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            child: const Text('Complete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Txt(
                          textAlign: TextAlign.start,
                          title: 'Hello ${widget.recruiter.fullname}! 👋',
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
                        CustomSearchWidget(
                          label: 'Search added jobs here...',
                          onFieldSubmit: (val) {
                            // searchController.searchJob(val, jobController);
                          },
                        ),
                      ],
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
                        return const Expanded(
                            child: Center(child: NoJobsAddedTemplate()));
                      }
                      // else if (searchController.searchedJobs.isNotEmpty) {
                      //   return Expanded(
                      //     child: SingleChildScrollView(
                      //       child: Container(
                      //         margin: const EdgeInsets.symmetric(
                      //             horizontal: Sizes.MARGIN_16),
                      //         child: Column(
                      //           children: [
                      //             const SizedBox(height: Sizes.HEIGHT_16),
                      //             ListView.builder(
                      //               shrinkWrap: true,
                      //               itemCount:
                      //                   searchController.searchedJobs.length,
                      //               itemBuilder: (context, index) {
                      //                 final job =
                      //                     searchController.searchedJobs[index];
                      //                 final company = searchController
                      //                     .searchJobCompany[index];
                      //                 if (job.jobAddedBy ==
                      //                     firebaseAuth.currentUser!.uid) {
                      //                   return Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(bottom: 14),
                      //                     child: ListTile(
                      //                       onTap: () {
                      //                         Get.to(JobDetailsScreen(
                      //                             company: company,
                      //                             job: job,
                      //                             isCompany: true));
                      //                       },
                      //                       tileColor: LightTheme.greyShade1,
                      //                       leading: IconButton(
                      //                           onPressed: () {
                      //                             jobController.deleteJob(
                      //                                 job.jobId, index);
                      //                           },
                      //                           icon: const Icon(Icons.delete)),
                      //                       title: Text(job.jobTitle),
                      //                       subtitle: Text(job.mode),
                      //                       trailing: IconButton(
                      //                           onPressed: () {
                      //                             Get.to(AddJobScreen(
                      //                               isEdit: true,
                      //                               job: job,
                      //                               jobController:
                      //                                   jobController,
                      //                             ));
                      //                           },
                      //                           icon: const Icon(Icons.edit)),
                      //                     ),
                      //                   );
                      //                 } else {
                      //                   return const SizedBox.shrink();
                      //                 }
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }
                      else {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: Sizes.HEIGHT_16),
                                ListView.builder(
                                  itemCount: jobController.jobList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final job = jobController.jobList[index];
                                    if (job.recruiterId == controller.getId()) {
                                      return RecruiterJobCard(
                                        job: job,
                                        controller: controller,
                                        companyId: widget.recruiter.companyId!,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
        floatingActionButton: widget.recruiter.companyId == null
            ? null
            : FloatingActionButton(
                onPressed: () {
                  jobController.clearFields();
                  Get.to(AddJobScreen(
                    isEdit: false,
                    jobController: jobController,
                    recruiterId: widget.recruiter.id,
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

class RecruiterJobCard extends StatelessWidget {
  const RecruiterJobCard({
    super.key,
    required this.job,
    required this.controller,
    required this.companyId,
  });

  final Job job;
  final AuthController controller;
  final String companyId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(JobDetailsScreen(
            job: job, authController: controller, companyId: companyId));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        height: 165,
        decoration: BoxDecoration(
          color: LightTheme.cardLightShade,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(1, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.65,
              child: Column(
                children: [
                  Txt(
                    title: job.title.capitalizeFirstOfEach,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    fontContainerWidth: 260,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.black,
                      fontSize: Sizes.TEXT_SIZE_20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Txt(
                    title: job.mode,
                    textAlign: TextAlign.start,
                    fontContainerWidth: 260,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.black,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Sizes.HEIGHT_18),
                  Txt(
                    title:
                        "\$${job.minSalary} - \$${job.maxSalary} Salary Offered",
                    textAlign: TextAlign.start,
                    textOverflow: TextOverflow.ellipsis,
                    fontContainerWidth: 260,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.black,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: Sizes.HEIGHT_18),
                  Txt(
                    title: job.postedDaysAgo(),
                    textAlign: TextAlign.start,
                    fontContainerWidth: 260,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.black,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: LightTheme.primaryColor,
                      width: 5.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: LightTheme.primaryColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.HEIGHT_18),
                Chip(
                  color: MaterialStateProperty.all(Colors.green),
                  label: Txt(
                    title: job.status.capitalizeFirst!,
                    textAlign: TextAlign.start,
                    fontContainerWidth: 40,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.black,
                      fontSize: Sizes.TEXT_SIZE_12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
