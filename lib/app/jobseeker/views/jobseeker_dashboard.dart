import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skillsift_flutter_app/app/jobseeker/controllers/all_jobs_controller.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/widgets/advanced_search_filter_field.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/job_card.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../bookmarks/controllers/bookmark_controller.dart';
import '../../bookmarks/views/bookmark_screen.dart';
import '../../notifications/views/notifcations_screen.dart';
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
      const Center(child: Text("FYP 2 Feature: History")),
      JobseekerProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          leadingWidth: 180,
          backgroundColor: LightTheme.whiteShade2,
          leading: Container(
            margin: const EdgeInsets.only(left: 20, top: 15),
            child: ClipRect(
              child: Image.asset(
                AppAssets.APP_TEXT,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 30,
              ),
              onPressed: () {
                Get.to(const NotificationsScreen());
              },
              color: LightTheme.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
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
              unselectedColor: LightTheme.secondaryColor,
              selectedColor: LightTheme.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.bookmark),
              title: const Text("Bookmark"),
              unselectedColor: LightTheme.secondaryColor,
              selectedColor: LightTheme.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.history),
              title: const Text("History"),
              unselectedColor: LightTheme.secondaryColor,
              selectedColor: LightTheme.primaryColor,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              unselectedColor: LightTheme.secondaryColor,
              selectedColor: LightTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildLogoutDialog(BuildContext context) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: LightTheme.white,
        title: const Text(
          'Confirm Logout',
          style: TextStyle(
            color: LightTheme.black,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: LightTheme.black,
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

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            height: 10,
          ),
          const Txt(
            title: "Job Feed",
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Txt(
            title: "Find jobs based on your skills",
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
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
                  return const Center(
                    child: Txt(
                      title: "No jobs available in applied filter.",
                      fontContainerWidth: double.infinity,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.secondaryColor,
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
                      return hasApplication
                          ? const SizedBox.shrink()
                          : JobCard(
                              job: job,
                              company: company,
                              bookmarkController: bmController);
                    },
                  );
                } else if (widget.jobController.jobList.isEmpty) {
                  return Container(
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
                            title: "No jobs available",
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
                      return hasApplication
                          ? const SizedBox.shrink()
                          : JobCard(
                              job: job,
                              company: widget.jobController.companyList[index],
                              bookmarkController: bmController,
                            );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
