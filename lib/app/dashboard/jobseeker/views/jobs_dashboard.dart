import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/bookmark/controllers/bookmark_controller.dart';
import 'package:skillsift_flutter_app/app/dashboard/jobseeker/controllers/all_jobs_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/widgets/job_card.dart';
import '../../../bookmark/views/bookmark_screen.dart';
import '../../../profile/jobseeker/views/jobseeker_profile_screen.dart';
import '../controllers/search_controller.dart' as ctrl;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      const Center(child: Text("History")),
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
            const Icon(
              Icons.mail,
              size: 30,
              color: LightTheme.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.notifications,
              size: 30,
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
  DisplayJobsScreen({
    super.key,
    required this.jobController,
  });

  final AllJobsController jobController;

  @override
  State<DisplayJobsScreen> createState() => _DisplayJobsScreenState();
}

class _DisplayJobsScreenState extends State<DisplayJobsScreen> {
  final bmController = Get.put(BookmarkController());

  final ctrl.SearchController searchController =
      Get.put(ctrl.SearchController());

  @override
  void dispose() {
    Get.delete<ctrl.SearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchWidget(
            onFieldSubmit: (value) {
              searchController.searchJob(value.trim(), widget.jobController);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Job Feed',
            style: TextStyle(
                color: LightTheme.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Jobs based on your skills',
            style: TextStyle(
                color: LightTheme.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(() {
              if (widget.jobController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: LightTheme.primaryColor,
                  ),
                );
              } else if (searchController.searchedJobs.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchController.searchedJobs.length,
                  itemBuilder: (context, index) {
                    final job = searchController.searchedJobs[index];
                    final company = searchController.searchJobCompany[index];
                    return JobCard(
                        job: job,
                        company: company,
                        bookmarkController: bmController);
                  },
                );
              } else if (widget.jobController.allJobList.isEmpty) {
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
                  itemCount: widget.jobController.allCompanyList.length,
                  itemBuilder: (context, index) {
                    final job = widget.jobController.allJobList[index];
                    final company = widget.jobController.allCompanyList[index];
                    return JobCard(
                        job: job,
                        company: company,
                        bookmarkController: bmController);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
