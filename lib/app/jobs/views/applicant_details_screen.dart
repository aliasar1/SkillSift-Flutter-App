// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/jobs/controllers/job_level_controller.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/models/level1_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../components/pdf_viewer_page.dart';

class ApplicantDetailsScreen extends StatefulWidget {
  final JobSeeker jobseeker;
  final Application initialApplication;
  final Level1 level1;
  final JobLevelController jobLevelController;
  final String jobTitle;

  const ApplicantDetailsScreen({
    Key? key,
    required this.jobseeker,
    required this.initialApplication,
    required this.level1,
    required this.jobLevelController, required this.jobTitle,
  }) : super(key: key);

  @override
  _ApplicantDetailsScreenState createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  late Application application;
  bool isButtonPressed = true;

  @override
  void initState() {
    super.initState();
    application = widget.initialApplication;
  }

  Future<void> updateApplicationStatus(
      String status, String currentLevel) async {
    await widget.jobLevelController.updateJobStatus(
      application.id!,
      status,
      currentLevel,
      widget.jobseeker.id,
widget.jobTitle,
    );
    application =
        (await widget.jobLevelController.findApplicationById(application.id!))!;
    setState(() {
      isButtonPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        iconTheme: IconThemeData(
            color: isDarkMode ? DarkTheme.primaryColor : LightTheme.black),
        title: Txt(
          title: "Applicant Details",
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
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              minRadius: 60,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: double.infinity,
              child: Txt(
                title: widget.jobseeker.fullname,
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: Get.height * 0.1,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_30,
                vertical: Sizes.MARGIN_12,
              ),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? DarkTheme.containerColor
                    : LightTheme.primaryColorLightestShade,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call,
                        color: LightTheme.primaryColor,
                      ),
                      Txt(
                        title: widget.jobseeker.contactNo,
                        fontContainerWidth: 200,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email,
                        color: LightTheme.primaryColor,
                      ),
                      Txt(
                        title: widget.jobseeker.email,
                        fontContainerWidth: 200,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Txt(
                title: "CV Rating: ${widget.level1.score}%",
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.primaryColor,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: LightTheme.grey,
              height: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Txt(
                title: "Currently on Round ${application.currentLevel}",
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: LightTheme.grey,
              height: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              buttonType: ButtonType.outline,
              textColor: LightTheme.primaryColor,
              color: LightTheme.primaryColor,
              text: "View Applicant CV",
              onPressed: () {
                Get.to(PdfViewerPage(
                  url: application.cvUrl,
                ));
              },
              hasInfiniteWidth: true,
            ),
            const Spacer(),
            if (application.currentLevel == "1" &&
                application.applicationStatus == "pending")
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonType: ButtonType.outline,
                      textColor: LightTheme.black,
                      color: LightTheme.primaryColor,
                      text: "Reject",
                      onPressed: () async {
                        await updateApplicationStatus("rejected", "1");
                      },
                      hasInfiniteWidth: true,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: CustomButton(
                      buttonType: ButtonType.text,
                      textColor: LightTheme.white,
                      color: LightTheme.primaryColor,
                      text: "Accept",
                      onPressed: () async {
                        int lvl = int.parse(application.currentLevel) + 1;
                        await updateApplicationStatus(
                            "accepted", lvl.toString());
                      },
                      hasInfiniteWidth: true,
                    ),
                  ),
                ],
              ),
            if (isButtonPressed &&
                ((application.currentLevel == "1" &&
                        application.applicationStatus == "rejected") ||
                    (application.currentLevel == "2" &&
                        application.applicationStatus == "pending")))
              CustomButton(
                buttonType: ButtonType.text,
                textColor: LightTheme.white,
                color: LightTheme.primaryColor,
                text: application.applicationStatus == 'rejected'
                    ? "Application Rejected"
                    : "Proceeded to Level 2",
                onPressed: null,
                hasInfiniteWidth: true,
              ),
          ],
        ),
      ),
    );
  }
}
