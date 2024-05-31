import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/jobs/controllers/job_controller.dart';
import 'package:skillsift_flutter_app/app/jobs/views/add_job_screen.dart';
import 'package:skillsift_flutter_app/core/extensions/helper_extensions.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/services/recruiter_api.dart';
import '../../jobseeker/views/apply_job_screen.dart';
import '../components/view_jd_pdf.dart';
import 'select_level_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen(
      {super.key,
      required this.job,
      required this.authController,
      this.companyId,
      this.isRecruiter = true,
      this.isApply = false});

  final Job job;
  final AuthController authController;
  final String? companyId;
  final bool isRecruiter;
  final bool isApply;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Company company;

  final jobController = Get.put(JobController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    jobController.toggleLoading2();
    if (widget.companyId == null) {
      final resp = await RecruiterApi.getRecruiterWithCompanyDetails(
          widget.job.recruiterId);
      company = Company.fromJson(resp['company_id']);
    } else {
      company =
          (await widget.authController.getCompanyDetails(widget.companyId!))!;
    }
    jobController.toggleLoading2();
  }

  Widget buildDetailRow(String label, String value) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: Sizes.SIZE_8),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode
                ? DarkTheme.whiteGreyColor.withOpacity(0.8)
                : LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget buildBulletList(List<String> skills) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills
          .map((skill) => Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: Sizes.ICON_SIZE_12,
                    color: LightTheme.primaryColor,
                  ),
                  const SizedBox(width: Sizes.SIZE_8),
                  Text(
                    skill.capitalizeFirstOfEach,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: isDarkMode
                          ? DarkTheme.whiteGreyColor.withOpacity(0.8)
                          : LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: isDarkMode ? DarkTheme.primaryColor : LightTheme.black),
        title: Txt(
          title: "Job Details",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode
                ? DarkTheme.whiteGreyColor
                : LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Obx(() {
        if (widget.authController.isLoading.value ||
            jobController.isLoading2.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: LightTheme.primaryColor,
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_12,
              vertical: Sizes.MARGIN_12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Txt(
                        textAlign: TextAlign.center,
                        title: widget.job.title,
                        fontContainerWidth: double.infinity,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_8),
                      Txt(
                        title: '${company.companyName} is hiring',
                        textAlign: TextAlign.center,
                        fontContainerWidth: double.infinity,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_8),
                      Chip(
                        side: BorderSide.none,
                        backgroundColor: isDarkMode
                            ? DarkTheme.containerColor
                            : LightTheme.primaryColorLightestShade,
                        label: Txt(
                          title: widget.job.industry.capitalizeFirstOfEach,
                          textAlign: TextAlign.center,
                          fontContainerWidth: Get.width * 0.65,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: isDarkMode
                                ? DarkTheme.primaryColor
                                : LightTheme.secondaryColor,
                            fontSize: Sizes.TEXT_SIZE_16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_8),
                      Txt(
                        title: "📍 ${company.street}",
                        textAlign: TextAlign.center,
                        fontContainerWidth: double.infinity,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor.withOpacity(0.5),
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_4),
                      Txt(
                        title:
                            "${company.city}, ${company.state}, ${company.country}",
                        textAlign: TextAlign.center,
                        fontContainerWidth: double.infinity,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.secondaryColor.withOpacity(0.5),
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.MARGIN_8,
                                vertical: Sizes.MARGIN_6,
                              ),
                              height: 70,
                              width: Get.width * 0.7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: LightTheme.primaryColor),
                              child: Column(
                                children: [
                                  Txt(
                                    title: "Salary offered",
                                    textAlign: TextAlign.center,
                                    fontContainerWidth: Get.height * 0.6,
                                    fontMaxLines: 150,
                                    textStyle: const TextStyle(
                                      fontFamily: "Poppins",
                                      color: LightTheme.white,
                                      fontSize: Sizes.TEXT_SIZE_14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: Sizes.SIZE_8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        color: LightTheme.white,
                                      ),
                                      Txt(
                                        title:
                                            "\$${widget.job.minSalary} - \$${widget.job.maxSalary} / month",
                                        textAlign: TextAlign.center,
                                        fontContainerWidth: Get.width * 0.5,
                                        fontMaxLines: 150,
                                        textStyle: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: LightTheme.white,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          createJobDetailContainer("Job Type", widget.job.type),
                          createJobDetailContainer(
                              "Working Model", widget.job.mode),
                        ],
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          createJobDetailContainer("Experience Level",
                              widget.job.experienceRequired),
                          createJobDetailContainer("Qualification Model",
                              widget.job.qualificationRequired),
                        ],
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      Txt(
                        title: "Job Description",
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        fontMaxLines: 150,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor
                              : LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      Txt(
                        title: widget.job.description,
                        textAlign: TextAlign.start,
                        fontContainerWidth: double.infinity,
                        fontMaxLines: 150,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode
                              ? DarkTheme.whiteGreyColor.withOpacity(0.7)
                              : LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                      buildDetailRow(
                        "Skills Required:",
                        "",
                      ),
                      const SizedBox(height: Sizes.SIZE_8),
                      buildBulletList(widget.job.skillTags),
                      const SizedBox(height: Sizes.SIZE_16),
                      CustomButton(
                        buttonType: ButtonType.text,
                        textColor: LightTheme.primaryColor,
                        color: isDarkMode
                            ? DarkTheme.cardBackgroundColor
                            : LightTheme.cardLightShade,
                        text: "View Job Description PDF",
                        onPressed: () {
                          Get.to(JdPdfViewer(
                            url: widget.job.jdUrl,
                          ));
                        },
                        hasInfiniteWidth: true,
                      ),
                      const SizedBox(height: Sizes.SIZE_16),
                    ],
                  ),
                ),
                if (widget.isRecruiter)
                  CustomButton(
                    buttonType: ButtonType.outline,
                    textColor: LightTheme.primaryColor,
                    color: LightTheme.primaryColor,
                    text: "See Applications",
                    onPressed: () {
                      Get.to(SelectLevelScreen(
                        jobId: widget.job.id,
                      ));
                    },
                    hasInfiniteWidth: true,
                  ),
              ],
            ),
          );
        }
      }),
      floatingActionButton: !widget.isRecruiter
          ? !widget.isApply
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(ApplyJobScreen(
                      jobId: widget.job.id,
                      jobJsonUrl: widget.job.jdJsonUrl == '' ? '' : '',
                      jobAddedBy: widget.job.recruiterId,
                    ));
                  },
                  backgroundColor: LightTheme.primaryColor,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                )
              : null
          : SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              foregroundColor: LightTheme.whiteShade2,
              backgroundColor: LightTheme.primaryColor,
              activeBackgroundColor: LightTheme.primaryColor,
              overlayOpacity: 0,
              children: [
                SpeedDialChild(
                  child: const Icon(
                    Icons.delete,
                    color: LightTheme.primaryColor,
                  ),
                  onTap: () => {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: isDarkMode
                            ? DarkTheme.containerColor
                            : LightTheme.whiteShade2,
                        title: const Text('Confirm Delete Job'),
                        content: Text(
                          'Are you sure you want to delete the job?',
                          style: TextStyle(
                              color: isDarkMode
                                  ? DarkTheme.whiteGreyColor
                                  : LightTheme.black),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: LightTheme.primaryColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                              LightTheme.primaryColor,
                            )),
                            onPressed: () {
                              jobController.deleteJob(widget.job.id);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                color: LightTheme.whiteShade2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  },
                ),
                SpeedDialChild(
                  child: const Icon(
                    Icons.edit,
                    color: LightTheme.primaryColor,
                  ),
                  onTap: () {
                    Get.to(AddJobScreen(
                      isEdit: true,
                      jobController: jobController,
                      job: widget.job,
                    ));
                  },
                ),
              ],
            ),
    );
  }

  Container createJobDetailContainer(String title, String subtitle) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.MARGIN_8,
        vertical: Sizes.MARGIN_6,
      ),
      height: 70,
      width: Get.width * 0.42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDarkMode
              ? DarkTheme.containerColor
              : LightTheme.primaryColorLightestShade),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt(
            title: title,
            textAlign: TextAlign.start,
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: isDarkMode
                  ? DarkTheme.whiteGreyColor.withOpacity(0.4)
                  : LightTheme.secondaryColor.withOpacity(0.4),
              fontSize: Sizes.TEXT_SIZE_14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: Sizes.SIZE_8),
          Txt(
            title: subtitle.capitalizeFirstOfEach,
            textAlign: TextAlign.start,
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
        ],
      ),
    );
  }

  RichText buildTextSpanRow(IconData icon, String d1, String d2) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        text: d1,
        style: TextStyle(
          fontFamily: "Poppins",
          color:
              isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.secondaryColor,
          fontSize: Sizes.TEXT_SIZE_14,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: d2.capitalizeFirstOfEach,
            style: const TextStyle(
              fontSize: Sizes.TEXT_SIZE_14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
