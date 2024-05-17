// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../case_base_qna/components/review_response_screen.dart';
import '../controllers/job_level3_controller.dart';

class Applicant3DetailsScreen extends StatefulWidget {
  final JobSeeker jobseeker;
  final Application initialApplication;
  final CaseStudySession level3;
  final JobLevel3Controller jobLevel3Controller;

  const Applicant3DetailsScreen({
    Key? key,
    required this.jobseeker,
    required this.initialApplication,
    required this.level3,
    required this.jobLevel3Controller,
  }) : super(key: key);

  @override
  _Applicant3DetailsScreenState createState() =>
      _Applicant3DetailsScreenState();
}

class _Applicant3DetailsScreenState extends State<Applicant3DetailsScreen> {
  late Application application;
  bool isButtonPressed = true;

  @override
  void initState() {
    super.initState();
    application = widget.initialApplication;
  }

  Future<void> updateApplicationStatus(
      String status, String currentLevel) async {
    await widget.jobLevel3Controller.updateJobStatus(
      application.id!,
      status,
      currentLevel,
    );
    application = (await widget.jobLevel3Controller
        .findApplicationById(application.id!))!;
    setState(() {
      isButtonPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Applicant Details",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
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
              child: Icon(
                Icons.person,
                size: 70,
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
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
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
                color: LightTheme.primaryColorLightestShade,
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
                title:
                    "QnA Speed Efficiency: ${widget.level3.score!.toStringAsFixed(2)}%",
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
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
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
              text: "View Applicant Response",
              onPressed: () async {
                Get.to(ReviewResponseScreen(
                  session: widget.level3,
                ));
              },
              hasInfiniteWidth: true,
            ),
            const Spacer(),
            if (application.currentLevel == "3" &&
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
                        await updateApplicationStatus("rejected", "3");
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
                        await updateApplicationStatus(
                            "accepted", application.currentLevel);
                      },
                      hasInfiniteWidth: true,
                    ),
                  ),
                ],
              ),
            if (isButtonPressed &&
                (application.currentLevel == "3" &&
                    application.applicationStatus == "rejected"))
              CustomButton(
                buttonType: ButtonType.text,
                textColor: LightTheme.white,
                color: LightTheme.primaryColor,
                text: application.applicationStatus == 'rejected'
                    ? "Application Rejected"
                    : "Proceeded to Interview Round",
                onPressed: null,
                hasInfiniteWidth: true,
              ),
            if (isButtonPressed &&
                (application.currentLevel == "3" &&
                    application.applicationStatus == "accepted"))
              const CustomButton(
                buttonType: ButtonType.text,
                textColor: LightTheme.white,
                color: LightTheme.primaryColor,
                text: "Proceeded to Interview Round",
                onPressed: null,
                hasInfiniteWidth: true,
              ),
          ],
        ),
      ),
    );
  }
}
