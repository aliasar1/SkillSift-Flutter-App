import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../components/bookmark_icon.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({Key? key}) : super(key: key);

  final BookmarkController bmController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Column(
            children: [
              const Txt(
                textAlign: TextAlign.start,
                title: "My Bookmarks",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_22,
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
                              return Container(
                                height: 200,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: LightTheme.cardLightShade,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
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
                                            textStyle: const TextStyle(
                                              fontFamily: "Poppins",
                                              color: LightTheme.black,
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
                                            "\$${job.minSalary} - \$${job.maxSalary} / month ",
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
                                                title: job.type,
                                                textAlign: TextAlign.start,
                                                fontContainerWidth: 150,
                                                textStyle: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color:
                                                      LightTheme.secondaryColor,
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
                                                title:
                                                    job.qualificationRequired,
                                                textAlign: TextAlign.start,
                                                fontContainerWidth: 130,
                                                textStyle: const TextStyle(
                                                  fontFamily: "Poppins",
                                                  color:
                                                      LightTheme.secondaryColor,
                                                  fontSize: Sizes.TEXT_SIZE_16,
                                                  fontWeight: FontWeight.normal,
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
                                          Expanded(
                                            child: Txt(
                                              title: job.postedDaysAgo(),
                                              textAlign: TextAlign.start,
                                              fontContainerWidth:
                                                  double.infinity,
                                              textStyle: const TextStyle(
                                                fontFamily: "Poppins",
                                                color: LightTheme.black,
                                                fontSize: Sizes.TEXT_SIZE_14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share,
                                                color: LightTheme.primaryColor,
                                              )),
                                        ],
                                      ),
                                    ],
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
