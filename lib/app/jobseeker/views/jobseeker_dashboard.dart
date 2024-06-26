import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skillsift_flutter_app/app/jobseeker/controllers/all_jobs_controller.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/widgets/advanced_search_filter_field.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/job_card.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../authentication/views/login.dart';
import '../../bookmarks/controllers/bookmark_controller.dart';
import '../../bookmarks/views/bookmark_screen.dart';
import '../../jobseeker_history/views/jobseeker_history_screen.dart';
import '../../profiles/jobseeker/views/jobseeker_profile_screen.dart';
import '../components/filter_sheet.dart';
import '../controllers/all_jobs_search_controller.dart';
import '../controllers/application_controller.dart';

class JobseekerDashboard extends StatefulWidget {
  const JobseekerDashboard({super.key});

  @override
  State<JobseekerDashboard> createState() => _JobseekerDashboardState();
}

class _JobseekerDashboardState extends State<JobseekerDashboard> {
  final controller = Get.put(AuthController());

  final jobController = Get.put(AllJobsController());

  var _currentIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      DisplayJobsScreen(jobController: jobController),
      BookmarkScreen(),
      JobSeekerHistoryScreen(),
      JobseekerProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        leading: Container(
          margin: const EdgeInsets.only(left: 20, top: 15),
          child: ClipRect(
            child: Image.asset(
              isDarkMode ? AppAssets.APP_TEXT_DARK : AppAssets.APP_TEXT,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              buildLogoutDialog(context);
            },
            child: const Icon(
              Icons.logout,
              size: 30,
              color: LightTheme.primaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            unselectedColor: isDarkMode
                ? const Color.fromARGB(255, 123, 123, 126)
                : LightTheme.secondaryColor,
            selectedColor: LightTheme.primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.bookmark),
            title: const Text("Bookmark"),
            unselectedColor: isDarkMode
                ? const Color.fromARGB(255, 123, 123, 126)
                : LightTheme.secondaryColor,
            selectedColor: LightTheme.primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text("History"),
            unselectedColor: isDarkMode
                ? const Color.fromARGB(255, 123, 123, 126)
                : LightTheme.secondaryColor,
            selectedColor: LightTheme.primaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            unselectedColor: isDarkMode
                ? const Color.fromARGB(255, 123, 123, 126)
                : LightTheme.secondaryColor,
            selectedColor: LightTheme.primaryColor,
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildLogoutDialog(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Get.dialog(
      AlertDialog(
        backgroundColor:
            isDarkMode ? DarkTheme.containerColor : LightTheme.white,
        title: Text(
          'Confirm Logout',
          style: TextStyle(
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: LightTheme.primaryColor),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LightTheme.primaryColor),
            ),
            onPressed: () async {
              controller.logout();
              Get.offAll(LoginScreen());
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: LightTheme.white),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayJobsScreen extends StatefulWidget {
  const DisplayJobsScreen({
    super.key,
    required this.jobController,
  });

  final AllJobsController jobController;

  @override
  State<DisplayJobsScreen> createState() => _DisplayJobsScreenState();
}

class _DisplayJobsScreenState extends State<DisplayJobsScreen> {
  final bmController = Get.put(BookmarkController());
  final AllJobsSearchController searchController =
      Get.put(AllJobsSearchController());
  final ApplicationController applicationController =
      Get.put(ApplicationController());

  @override
  void dispose() {
    Get.delete<AllJobsSearchController>();
    super.dispose();
  }

  Future<void> _refreshJobs() async {
    widget.jobController.companyList.clear();
    widget.jobController.jobList.clear();
    applicationController.jobseekerApplications.clear();
    applicationController.getApplicationsOfJobSeeker();
    await widget.jobController.loadAllJobs();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchFilterWidget(
            onFieldSubmit: (value) {
              searchController.searchJob(value.trim(), widget.jobController);
            },
            onFilterTap: () async {
              await createFilterSheet(
                  context, searchController, widget.jobController);
            },
          ),
          const SizedBox(height: 10),
          Txt(
            title: "Job Feed",
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Txt(
            title: "Find jobs based on your skills",
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              color: DarkTheme.whiteGreyColor,
              backgroundColor: LightTheme.primaryColor,
              onRefresh: _refreshJobs,
              child: Obx(
                () {
                  if (widget.jobController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: LightTheme.primaryColor,
                      ),
                    );
                  } else if (widget.jobController.jobList.isEmpty &&
                      searchController.isFilterResultEmpty.value) {
                    return Center(
                      child: Txt(
                        title: "No jobs available in applied filter.",
                        fontContainerWidth: double.infinity,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (searchController.searchedJobs.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchController.searchedJobs.length,
                      itemBuilder: (context, index) {
                        final job = searchController.searchedJobs[index];
                        final company = searchController.companyList[index];
                        final hasApplication = applicationController
                            .jobseekerApplications
                            .any((application) => application.jobId == job.id);
                        return JobCard(
                          job: job,
                          company: company,
                          bookmarkController: bmController,
                          isApplied: hasApplication,
                        );
                      },
                    );
                  } else if (widget.jobController.jobList.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Sizes.MARGIN_16),
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
                          const SizedBox(height: 20),
                          Center(
                            child: Txt(
                              title: "No jobs available",
                              fontContainerWidth: double.infinity,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: isDarkMode
                                    ? DarkTheme.whiteGreyColor
                                    : LightTheme.secondaryColor,
                                fontSize: Sizes.TEXT_SIZE_16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: Sizes.HEIGHT_160),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.jobController.jobList.length,
                      itemBuilder: (context, index) {
                        final job = widget.jobController.jobList[index];
                        final hasApplication = applicationController
                            .jobseekerApplications
                            .any((application) => application.jobId == job.id);
                        return JobCard(
                          job: job,
                          company: widget.jobController.companyList[index],
                          bookmarkController: bmController,
                          isApplied: hasApplication,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
