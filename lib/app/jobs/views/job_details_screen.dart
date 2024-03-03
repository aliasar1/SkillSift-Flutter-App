import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/core/extensions/helper_extensions.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen(
      {super.key,
      required this.job,
      required this.authController,
      required this.companyId,
      this.isRecruiter = true});

  final Job job;
  final AuthController authController;
  final String companyId;
  final bool isRecruiter;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Company company;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    company =
        (await widget.authController.getCompanyDetails(widget.companyId))!;
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: Sizes.SIZE_8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget buildBulletList(List<String> skills) {
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
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: LightTheme.white),
          backgroundColor: LightTheme.primaryColor,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "Job Details",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Obx(() {
          if (widget.authController.isLoading.value) {
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
              child: ListView(
                children: [
                  Txt(
                    textAlign: TextAlign.start,
                    title: widget.job.title,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Sizes.SIZE_8),
                  Txt(
                    title: '${company.companyName} is recruiting.',
                    textAlign: TextAlign.start,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: Sizes.SIZE_4),
                  Txt(
                    title: "📍 ${company.street}",
                    textAlign: TextAlign.start,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: Sizes.SIZE_4),
                  Txt(
                    title:
                        "${company.city}, ${company.state}, ${company.country}",
                    textAlign: TextAlign.start,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: Sizes.SIZE_16),
                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  const SizedBox(height: Sizes.SIZE_16),
                  Txt(
                    title: widget.job.description,
                    textAlign: TextAlign.start,
                    fontContainerWidth: double.infinity,
                    fontMaxLines: 150,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: Sizes.SIZE_16),
                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  const SizedBox(height: Sizes.SIZE_16),
                  buildTextSpanRow(Icons.work, "Experience Required:  ",
                      widget.job.experienceRequired),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildTextSpanRow(Icons.attach_money, "Salary Offering:  ",
                      "\$${widget.job.minSalary} - \$${widget.job.maxSalary} / month"),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildTextSpanRow(Icons.school, "Qualification Required:  ",
                      widget.job.qualificationRequired),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildTextSpanRow(
                      Icons.factory, "Job Industry:  ", widget.job.industry),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildTextSpanRow(Icons.title, "Job Type:  ", widget.job.type),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildTextSpanRow(Icons.badge, "Job Mode:  ", widget.job.mode),
                  const SizedBox(height: Sizes.SIZE_16),
                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),
                  const SizedBox(height: Sizes.SIZE_16),
                  buildDetailRow(
                    "Skills Required:",
                    "",
                  ),
                  const SizedBox(height: Sizes.SIZE_8),
                  buildBulletList(widget.job.skillTags),
                ],
              ),
            );
          }
        }),
        floatingActionButton: !widget.isRecruiter
            ? null
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
                          backgroundColor: LightTheme.whiteShade2,
                          title: const Text('Confirm Delete Job'),
                          content: const Text(
                            'Are you sure you want to delete the job?',
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
                              onPressed: () {},
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
                    onTap: () {},
                  ),
                ],
              ),
      ),
    );
  }

  RichText buildTextSpanRow(IconData icon, String d1, String d2) {
    return RichText(
      text: TextSpan(
        text: d1,
        style: const TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.secondaryColor,
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
