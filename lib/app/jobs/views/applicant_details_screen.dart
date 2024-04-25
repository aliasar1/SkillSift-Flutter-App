import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../components/pdf_viewer_page.dart';

class ApplicantDetailsScreen extends StatelessWidget {
  const ApplicantDetailsScreen({super.key});

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
            const SizedBox(
              width: double.infinity,
              child: Txt(
                title: "Ali Asar",
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: LightTheme.primaryColor,
                      ),
                      Txt(
                        title: "0331231231",
                        fontContainerWidth: 200,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: LightTheme.primaryColor,
                      ),
                      Txt(
                        title: "ali@gmail.com",
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
                title: "CV Rating: 72.2%",
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
            const SizedBox(
              width: double.infinity,
              child: Txt(
                title: "Currently on Round 1",
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
                textStyle: TextStyle(
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
                Get.to(const PdfViewerPage(
                  url:
                      'https://skillsift.s3.eu-north-1.amazonaws.com/jobs/662a1d9b55c7662e5fbe4746/662a1d9b55c7662e5fbe4746.pdf',
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
