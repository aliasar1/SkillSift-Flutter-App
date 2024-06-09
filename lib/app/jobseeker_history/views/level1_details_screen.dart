import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/helpers/circle_avatart_profile_builder.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/level1_model.dart';
import '../../../core/services/level1_api.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../jobs/components/pdf_viewer_page.dart';

class Level1DetailsScreen extends StatefulWidget {
  const Level1DetailsScreen(
      {super.key,
      required this.application,
      required this.jobName,
      required this.jobId,
      required this.jobseeker});

  final Application application;
  final String jobName;
  final String jobId;
  final JobSeeker jobseeker;

  @override
  State<Level1DetailsScreen> createState() => _Level1DetailsScreenState();
}

class _Level1DetailsScreenState extends State<Level1DetailsScreen> {
  bool isLoading = true;
  late Level1 l1;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      l1 = await Level1Api.getLevel1ByApplicationId(widget.application.id!);
    } catch (e) {
      Get.snackbar('Error', 'Failed to check application status');
    }
    setState(() {
      isLoading = false;
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: LightTheme.primaryColor,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Sizes.MARGIN_12,
                vertical: Sizes.MARGIN_12,
              ),
              child: Column(
                children: <Widget>[
                  buildCircularAvatar(widget.jobseeker.profilePicUrl, 70),
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
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
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
                      title: "CV Rating: ${l1.score}",
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
                      title:
                          "Currently on Round ${widget.application.currentLevel}",
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
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
                    text: "View  CV",
                    onPressed: () {
                      Get.to(PdfViewerPage(
                        url: widget.application.cvUrl,
                      ));
                    },
                    hasInfiniteWidth: true,
                  ),
                  const Spacer(),
                  if (int.parse(widget.application.currentLevel) > 1)
                    CustomButton(
                      buttonType: ButtonType.text,
                      textColor: LightTheme.white,
                      color: LightTheme.primaryColor,
                      text: widget.application.applicationStatus == 'rejected'
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
