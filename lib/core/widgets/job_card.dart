import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skillsift_flutter_app/app/jobs/views/job_details_screen.dart';

import '../../app/authentication/controllers/auth_controller.dart';
import '../../app/bookmarks/components/bookmark_icon.dart';
import '../../app/bookmarks/controllers/bookmark_controller.dart';
import '../exports/constants_exports.dart';
import '../models/company_model.dart';
import '../models/job_model.dart';
import 'custom_text.dart';

class JobCard extends StatelessWidget {
  JobCard({
    super.key,
    required this.job,
    required this.company,
    required this.bookmarkController,
  });

  final Job job;
  final Company company;
  final BookmarkController bookmarkController;

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(JobDetailsScreen(
          job: job,
          companyId: company.id,
          isRecruiter: false,
          authController: authController,
          isApply: true,
        ));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: LightTheme.cardLightShade,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                          job: job, bookmarkController: bookmarkController),
                    ],
                  ),
                  Txt(
                    title: company.companyName,
                    textAlign: TextAlign.start,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_14,
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
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Txt(
                title: "\$${job.minSalary} - \$${job.maxSalary} per month ",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.blackShade4,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 8,
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
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_14,
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
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Txt(
                      title: job.postedDaysAgo(),
                      textAlign: TextAlign.start,
                      fontContainerWidth: 120,
                      textStyle: const TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.primaryColor,
                        fontSize: Sizes.TEXT_SIZE_14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Share.share(job.jdUrl, subject: 'Check out this job.');
                      },
                      icon: const Icon(
                        Icons.share,
                        color: LightTheme.primaryColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
