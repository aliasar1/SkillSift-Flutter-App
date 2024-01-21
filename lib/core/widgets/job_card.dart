import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/bookmark/components/bookmark_icon.dart';
import 'package:skillsift_flutter_app/app/job_details/views/job_details_screen.dart';

import '../../app/bookmark/controllers/bookmark_controller.dart';
import '../exports/constants_exports.dart';
import '../models/company_model.dart';
import '../models/job_model.dart';
import 'custom_text.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
    required this.company,
    this.isFav = false,
    this.isCompany = false,
    required this.bookmarkController,
  });

  final Job job;
  final bool isFav;
  final bool isCompany;
  final Company company;
  final BookmarkController? bookmarkController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(JobDetailsScreen(
          job: job,
          company: company,
          isCompany: isCompany,
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
                      bookmarkController == null
                          ? Container()
                          : BookmarkIcon(
                              job: job,
                              bookmarkController: bookmarkController!),
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
                title: "\$ ${job.minSalary} - \$ ${job.maxSalary} / month ",
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
              Txt(
                title: job.postedDaysAgo(),
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
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
      ),
    );
  }
}
