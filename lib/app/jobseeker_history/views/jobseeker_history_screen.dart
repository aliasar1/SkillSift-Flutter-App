import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/core/models/application_model.dart';
import 'package:skillsift_flutter_app/core/services/job_api.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/services/recruiter_api.dart';
import '../../../core/widgets/custom_text.dart';
import '../../jobseeker/controllers/application_controller.dart';

class JobSeekerHistoryScreen extends StatelessWidget {
  JobSeekerHistoryScreen({super.key});

  final ApplicationController applicationController =
      Get.put(ApplicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.MARGIN_12,
        vertical: Sizes.MARGIN_12,
      ),
      child: Column(
        children: [
          const Txt(
            textAlign: TextAlign.start,
            title: "Applications History",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(
            () {
              if (applicationController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: LightTheme.primaryColor,
                  ),
                );
              } else if (applicationController.jobseekerApplications.isEmpty) {
                return const Center(
                  child: Txt(
                    title: "No jobs applied yet.",
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          applicationController.jobseekerApplications.length,
                      itemBuilder: (context, index) {
                        final data =
                            applicationController.jobseekerApplications[index];
                        return JobseekerHistoryCard(data: data);
                      }),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}

class JobseekerHistoryCard extends StatefulWidget {
  const JobseekerHistoryCard({
    super.key,
    required this.data,
  });

  final Application data;

  @override
  State<JobseekerHistoryCard> createState() => _JobseekerHistoryCardState();
}

class _JobseekerHistoryCardState extends State<JobseekerHistoryCard> {
  late Job job;
  late Company company;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    try {
      final jobResp = await JobApi.getJobById(widget.data.jobId);
      job = Job.fromJson(jobResp);
      final resp =
          await RecruiterApi.getRecruiterWithCompanyDetails(job.recruiterId);
      final companyData = Company.fromJson(resp['company_id']);
      company = companyData;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: Get.height * 0.125,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_6,
                vertical: Sizes.MARGIN_6,
              ),
              decoration: BoxDecoration(
                color: LightTheme.cardLightShade,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
          )
        : Container(
            height: Get.height * 0.125,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_6,
              vertical: Sizes.MARGIN_6,
            ),
            decoration: BoxDecoration(
              color: LightTheme.cardLightShade,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_6,
                vertical: Sizes.MARGIN_6,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.55,
                        child: Txt(
                          title: job.title,
                          textAlign: TextAlign.start,
                          textOverflow: TextOverflow.ellipsis,
                          fontContainerWidth: Get.width * 0.3,
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            color: LightTheme.black,
                            fontSize: Sizes.TEXT_SIZE_20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: LightTheme.grey,
                        labelPadding: const EdgeInsets.all(0),
                        label: Txt(
                          title: widget.data.applicationStatus.capitalizeFirst!,
                          textAlign: TextAlign.center,
                          textOverflow: TextOverflow.ellipsis,
                          textStyle: const TextStyle(
                            fontFamily: "Poppins",
                            color: LightTheme.primaryColor,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Txt(
                        title: company.companyName,
                        textAlign: TextAlign.start,
                        textStyle: const TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Txt(
                        title: "Currently on round ${widget.data.currentLevel}",
                        textAlign: TextAlign.center,
                        fontContainerWidth: Get.width * 0.4,
                        textStyle: const TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
