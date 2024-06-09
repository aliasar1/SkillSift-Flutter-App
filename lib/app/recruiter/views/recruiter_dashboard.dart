import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/app/authentication/views/company_signup.dart';
import 'package:skillsift_flutter_app/app/jobs/controllers/job_controller.dart';
import 'package:skillsift_flutter_app/app/jobs/views/add_job_screen.dart';
import 'package:skillsift_flutter_app/app/jobs/views/job_details_screen.dart';
import 'package:skillsift_flutter_app/core/extensions/helper_extensions.dart';
import 'package:skillsift_flutter_app/core/services/application_api.dart';
import 'package:skillsift_flutter_app/core/widgets/templates/no_jobs_added.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/job_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/widgets/recruiter_drawer.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../controllers/recruiter_search_controller.dart';

class RecruiterDashboard extends StatefulWidget {
  const RecruiterDashboard({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  final controller = Get.put(AuthController());
  final jobController = Get.put(JobController());
  final searchController = Get.put(RecruiterJobsSearchController());

  @override
  void dispose() {
    Get.delete<RecruiterJobsSearchController>();
    super.dispose();
  }

  Future<void> _refreshJobs() async {
    jobController.jobList.clear();
    await jobController.loadAllJobs();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        surfaceTintColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () => widget.recruiter.companyId == null
                ? Get.to(CompanySignupScreen(recruiter: widget.recruiter))
                : null,
            child: Stack(
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
          ),
          SizedBox(
            width: Get.width * 0.03,
          ),
        ],
      ),
      drawer:
          RecruiterDrawer(recruiter: widget.recruiter, controller: controller),
      body: widget.recruiter.companyId == null &&
              (controller.getSkipFlag() == null || !controller.getSkipFlag()!)
          ? Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? DarkTheme.containerColor : LightTheme.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
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
                      child: Icon(Icons.warning,
                          color: isDarkMode
                              ? DarkTheme.containerColor
                              : Colors.white,
                          size: 100),
                    ),
                    const SizedBox(height: Sizes.HEIGHT_24),
                    Txt(
                      title: "Account Activation Required",
                      textAlign: TextAlign.center,
                      fontContainerWidth: 260,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Sizes.HEIGHT_18),
                    Txt(
                      title:
                          "Please complete your company details in order to activate your account.",
                      textAlign: TextAlign.center,
                      fontContainerWidth: 280,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
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
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_8),
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
                        readOnly:
                            widget.recruiter.companyId == null ? true : false,
                        onFieldSubmit: (val) {
                          searchController.searchJob(val, jobController);
                        },
                      ),
                      const SizedBox(height: Sizes.HEIGHT_8),
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
                      return const Center(child: NoJobsAddedTemplate());
                    } else if (searchController.searchedJobs.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: searchController.searchedJobs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final job = searchController.searchedJobs[index];
                            return job.recruiterId == controller.getId()
                                ? RecruiterJobCard(
                                    job: job,
                                    controller: controller,
                                    companyId: widget.recruiter.companyId!,
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: RefreshIndicator(
                          color: DarkTheme.whiteGreyColor,
                          backgroundColor: LightTheme.primaryColor,
                          onRefresh: _refreshJobs,
                          child: ListView.builder(
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
    );
  }
}

class RecruiterJobCard extends StatefulWidget {
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
  State<RecruiterJobCard> createState() => _RecruiterJobCardState();
}

class _RecruiterJobCardState extends State<RecruiterJobCard> {
  bool isLoading = true;
  int totalApplications = 0;

  @override
  void initState() {
    super.initState();
    getTotalApplications();
  }

  Future<void> getTotalApplications() async {
    try {
      final resp =
          await ApplicationApi.getTotalApplicationsOfJob(widget.job.id);
      totalApplications = resp;
      setState(() {});
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isLoading
        ? Shimmer.fromColors(
            baseColor: isDarkMode
                ? Colors.grey[900]!
                : const Color.fromARGB(31, 241, 241, 241),
            highlightColor: isDarkMode
                ? Colors.grey[500]!
                : const Color.fromARGB(255, 223, 222, 222),
            child: buildShimmerWidget(),
          )
        : InkWell(
            onTap: () {
              Get.to(JobDetailsScreen(
                  job: widget.job,
                  authController: widget.controller,
                  companyId: widget.companyId));
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              height: 165,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? DarkTheme.cardBackgroundColor
                    : LightTheme.cardLightShade,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.grey.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.5),
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
                    width: Get.width * 0.6,
                    child: Column(
                      children: [
                        Txt(
                          title: widget.job.title.capitalizeFirstOfEach,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          fontContainerWidth: 260,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode
                                ? DarkTheme.whiteGreyColor
                                : LightTheme.black,
                            fontSize: Sizes.TEXT_SIZE_20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Txt(
                          title: widget.job.mode,
                          textAlign: TextAlign.start,
                          fontContainerWidth: 260,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode
                                ? DarkTheme.whiteGreyColor
                                : LightTheme.black,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: Sizes.HEIGHT_18),
                        Txt(
                          title:
                              "\$${widget.job.minSalary} - \$${widget.job.maxSalary} Salary Offered",
                          textAlign: TextAlign.start,
                          textOverflow: TextOverflow.ellipsis,
                          fontContainerWidth: 260,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode
                                ? DarkTheme.whiteGreyColor
                                : LightTheme.black,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: Sizes.HEIGHT_18),
                        Txt(
                          title: widget.job.postedDaysAgo(),
                          textAlign: TextAlign.start,
                          fontContainerWidth: 260,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode
                                ? DarkTheme.whiteGreyColor
                                : LightTheme.black,
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
                        child: Center(
                          child: Text(
                            totalApplications.toString(),
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : LightTheme.primaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_18),
                      Chip(
                        color: MaterialStateProperty.all(
                          isDarkMode
                              ? DarkTheme.darkGreyColor
                              : LightTheme.primaryColorLightestShade,
                        ),
                        label: Txt(
                          title: widget.job.status.capitalizeFirst!,
                          textAlign: TextAlign.center,
                          fontContainerWidth: 70,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode ? Colors.white : LightTheme.black,
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

  Widget buildShimmerWidget() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      height: 165,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black12 : LightTheme.cardLightShade,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black38 : Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(1, 3),
          ),
        ],
      ),
    );
  }
}
