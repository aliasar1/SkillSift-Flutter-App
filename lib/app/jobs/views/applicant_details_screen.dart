import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../components/pdf_viewer_page.dart';

class ApplicantDetailsScreen extends StatelessWidget {
  const ApplicantDetailsScreen(
      {super.key, required this.jobseeker, required this.application});

  final JobSeeker jobseeker;
  final Application application;

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
          children: [
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
                title: jobseeker.fullname,
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
                        title: jobseeker.contactNo,
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
                        title: jobseeker.email,
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
            const SizedBox(
              width: double.infinity,
              child: Txt(
                title: "CV Rating: ${22}%",
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
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
              text: "View Applicant CV",
              onPressed: () {
                Get.to(PdfViewerPage(
                  url: application.cvUrl,
                ));
              },
              hasInfiniteWidth: true,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonType: ButtonType.outline,
                    textColor: LightTheme.black,
                    color: LightTheme.primaryColor,
                    text: "Reject",
                    onPressed: () {},
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
                    onPressed: () {},
                    hasInfiniteWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
