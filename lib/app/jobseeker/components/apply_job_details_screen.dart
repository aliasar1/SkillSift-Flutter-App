import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:skillsift_flutter_app/core/extensions/helper_extensions.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';

class ApplyJobDetailsScreen extends StatelessWidget {
  const ApplyJobDetailsScreen({
    Key? key,
    required this.job,
    required this.company,
  }) : super(key: key);

  final Job job;
  final Company company;

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
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: ListView(
            children: [
              Txt(
                textAlign: TextAlign.start,
                title: job.title,
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
              const SizedBox(height: Sizes.SIZE_4),
              Txt(
                title: "📍 ${company.street}",
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
                title: "${company.city}, ${company.state}, ${company.country}",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
                  fontSize: Sizes.TEXT_SIZE_16,
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
                title: job.description,
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
              buildTextSpanRow(
                  Icons.work, "Experience Required:  ", job.experienceRequired),
              const SizedBox(height: Sizes.SIZE_8),
              buildTextSpanRow(Icons.attach_money, "Salary Offering:  ",
                  "\$${job.minSalary} - \$${job.maxSalary} / month"),
              const SizedBox(height: Sizes.SIZE_8),
              buildTextSpanRow(Icons.school, "Qualification Required:  ",
                  job.qualificationRequired),
              const SizedBox(height: Sizes.SIZE_8),
              buildTextSpanRow(Icons.factory, "Job Industry:  ", job.industry),
              const SizedBox(height: Sizes.SIZE_8),
              buildTextSpanRow(Icons.title, "Job Type:  ", job.type),
              const SizedBox(height: Sizes.SIZE_8),
              buildTextSpanRow(Icons.badge, "Job Mode:  ", job.mode),
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
              buildBulletList(job.skillTags),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.to(ApplyJobScreen(
            //   jobId: job.jobId,
            // ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
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
