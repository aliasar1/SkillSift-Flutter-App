import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/local/cache_manager.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/recruiter_drawer.dart';
import '../../../core/widgets/templates/no_jobs_added.dart';
import '../../jobs/controllers/job_controller.dart';
import '../../jobs/views/job_details_screen.dart';

class RecruiterHistoryScreen extends StatefulWidget {
  const RecruiterHistoryScreen({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<RecruiterHistoryScreen> createState() => _RecruiterHistoryScreenState();
}

class _RecruiterHistoryScreenState extends State<RecruiterHistoryScreen>
    with CacheManager {
  final authController = Get.put(AuthController());

  final jobController = Get.put(JobController());
  bool isLoading = false;

  Future<void> _refreshJobs() async {
    setState(() {
      isLoading = true;
    });
    jobController.jobList.clear();
    await jobController.loadAllJobs();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        title: Txt(
          textAlign: TextAlign.start,
          title: "Jobs History",
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode ? DarkTheme.whiteColor : LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      ),
      drawer: RecruiterDrawer(
          recruiter: widget.recruiter, controller: authController),
      body: isLoading || jobController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: LightTheme.primaryColor,
              ),
            )
          : Obx(() {
              if (jobController.jobList.isEmpty) {
                return const Center(child: NoJobsAddedTemplate());
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Sizes.MARGIN_12,
                    vertical: Sizes.MARGIN_12,
                  ),
                  child: RefreshIndicator(
                    color: DarkTheme.whiteGreyColor,
                    backgroundColor: LightTheme.primaryColor,
                    onRefresh: _refreshJobs,
                    child: ListView.builder(
                      itemCount: jobController.jobList.length,
                      itemBuilder: (context, index) {
                        final job = jobController.jobList[index];
                        if (job.recruiterId == getId()) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                final response = await AuthApi.getCurrentUser(
                                    true, getId()!);
                                final recruiter = Recruiter.fromJson(response);
                                Get.to(
                                  JobDetailsScreen(
                                      job: job,
                                      authController: authController,
                                      companyId: recruiter.companyId!),
                                );
                              },
                              child: ListTile(
                                tileColor: isDarkMode
                                    ? DarkTheme.cardBackgroundColor
                                    : LightTheme.cardLightShade,
                                leading: job.status == 'completed'
                                    ? const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.pending,
                                        color: LightTheme.primaryColor,
                                        size: 30,
                                      ),
                                title: Txt(
                                  textAlign: TextAlign.start,
                                  title: job.title.capitalizeFirst!,
                                  fontContainerWidth: double.infinity,
                                  textStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    color: isDarkMode
                                        ? DarkTheme.whiteColor
                                        : LightTheme.black,
                                    fontSize: Sizes.TEXT_SIZE_20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Txt(
                                  textAlign: TextAlign.start,
                                  title: job.status.capitalizeFirst!,
                                  fontContainerWidth: double.infinity,
                                  textStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    color: isDarkMode
                                        ? DarkTheme.whiteColor
                                        : LightTheme.black,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: LightTheme.primaryColor,
                                ),
                              ),
                            ),
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
    );
  }
}
