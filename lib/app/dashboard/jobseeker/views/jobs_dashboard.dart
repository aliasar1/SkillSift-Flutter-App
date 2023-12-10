import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/dashboard/jobseeker/controllers/all_jobs_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/exports/constants_exports.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key});

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
      const Center(child: Text("Bookmark")),
      const Center(child: Text("History")),
      const Center(child: Text("Profile")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          leadingWidth: 180,
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

class DisplayJobsScreen extends StatelessWidget {
  const DisplayJobsScreen({
    super.key,
    required this.jobController,
  });

  final AllJobsController jobController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchWidget(),
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
              if (jobController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: LightTheme.primaryColor,
                  ),
                );
              } else if (jobController.allJobList.isEmpty) {
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
                  itemCount: jobController.allComapnyList.length,
                  itemBuilder: (context, index) {
                    final job = jobController.allJobList[index];
                    final company = jobController.allComapnyList[index];
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      decoration: BoxDecoration(
                        color: LightTheme.cardLightShade,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Txt(
                                      title: job.jobTitle,
                                      textAlign: TextAlign.start,
                                      fontContainerWidth: 260,
                                      textStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: LightTheme.black,
                                        fontSize: Sizes.TEXT_SIZE_20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.bookmark_outline),
                                  ],
                                ),
                                Txt(
                                  title: company.companyName,
                                  textAlign: TextAlign.start,
                                  fontContainerWidth: double.infinity,
                                  textStyle: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: LightTheme.secondaryColor,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Txt(
                                  title: company.city,
                                  textAlign: TextAlign.start,
                                  fontContainerWidth: double.infinity,
                                  textStyle: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: LightTheme.secondaryColor,
                                    fontSize: Sizes.TEXT_SIZE_16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Txt(
                              title:
                                  "\$ ${job.minSalary} - \$ ${job.maxSalary} a month  ${job.jobType}",
                              textAlign: TextAlign.start,
                              fontContainerWidth: double.infinity,
                              textStyle: const TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.blackShade4,
                                fontSize: Sizes.TEXT_SIZE_16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.send,
                                      color: LightTheme.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Txt(
                                      title: job.jobType,
                                      textAlign: TextAlign.start,
                                      fontContainerWidth: 150,
                                      textStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: LightTheme.secondaryColor,
                                        fontSize: Sizes.TEXT_SIZE_16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timeline,
                                      color: LightTheme.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Txt(
                                      title: job.qualificationRequired,
                                      textAlign: TextAlign.start,
                                      fontContainerWidth: 130,
                                      textStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: LightTheme.secondaryColor,
                                        fontSize: Sizes.TEXT_SIZE_16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Txt(
                              title: "Posted 5 days ago",
                              textAlign: TextAlign.start,
                              fontContainerWidth: double.infinity,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.black,
                                fontSize: Sizes.TEXT_SIZE_14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
