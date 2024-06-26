import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skillsift_flutter_app/app/jobs/views/job_details_screen.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../components/bookmark_icon.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({Key? key}) : super(key: key);

  final BookmarkController bmController = Get.put(BookmarkController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Column(
            children: [
              Txt(
                textAlign: TextAlign.start,
                title: "My Bookmarks",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Sizes.SIZE_12),
              Expanded(
                child: bmController.isRendering.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: LightTheme.primaryColor,
                        ),
                      )
                    : bmController.bookmarkJobs.isEmpty
                        ? const Column(
                            children: [
                              SizedBox(height: Sizes.SIZE_24 * 5),
                              Center(child: Text('No jobs bookmarked')),
                            ],
                          )
                        : ListView.builder(
                            itemCount: bmController.bookmarkJobs.length,
                            itemBuilder: (context, index) {
                              final job = bmController.bookmarkJobs[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(JobDetailsScreen(
                                    job: job,
                                    authController: authController,
                                    isRecruiter: false,
                                    isApply: true,
                                  ));
                                },
                                child: Container(
                                  height: 160,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? DarkTheme.cardBackgroundColor
                                        : LightTheme.cardLightShade,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDarkMode
                                            ? Colors.transparent
                                            : Colors.grey.withOpacity(0.5),
                                        spreadRadius: isDarkMode ? 1 : 4,
                                        blurRadius: 6,
                                        offset: const Offset(2, 3),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Txt(
                                              title: job.title,
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
                                            const Spacer(),
                                            BookmarkIcon(
                                              job: job,
                                              bookmarkController: bmController,
                                            ),
                                          ],
                                        ),
                                        Txt(
                                          title:
                                              "\$${job.minSalary} - \$${job.maxSalary} per month ",
                                          textAlign: TextAlign.start,
                                          fontContainerWidth: double.infinity,
                                          textStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: isDarkMode
                                                ? DarkTheme.whiteGreyColor
                                                : LightTheme.blackShade4,
                                            fontSize: Sizes.TEXT_SIZE_14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.send,
                                                  color:
                                                      LightTheme.primaryColor,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Txt(
                                                  title: job.type,
                                                  textAlign: TextAlign.start,
                                                  fontContainerWidth: 120,
                                                  textStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: isDarkMode
                                                        ? DarkTheme
                                                            .whiteGreyColor
                                                        : LightTheme
                                                            .secondaryColor,
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.timeline,
                                                  color:
                                                      LightTheme.primaryColor,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Txt(
                                                  title:
                                                      job.qualificationRequired,
                                                  textAlign: TextAlign.start,
                                                  fontMaxLines: 1,
                                                  fontContainerWidth: 120,
                                                  textStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: isDarkMode
                                                        ? DarkTheme
                                                            .whiteGreyColor
                                                        : LightTheme
                                                            .secondaryColor,
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Chip(
                                              label: Txt(
                                                title: 'Active',
                                                textAlign: TextAlign.start,
                                                fontContainerWidth: 50,
                                                textStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: isDarkMode
                                                      ? DarkTheme.whiteGreyColor
                                                      : LightTheme.primaryColor,
                                                  fontSize: Sizes.TEXT_SIZE_14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  Share.share(job.jdUrl,
                                                      subject:
                                                          'Check out this job');
                                                },
                                                icon: const Icon(
                                                  Icons.share,
                                                  color:
                                                      LightTheme.primaryColor,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
