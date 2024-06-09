// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/core/models/case_study_session_model.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/dark_theme.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/helpers/circle_avatart_profile_builder.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_date_time_field.dart';
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
  bool isLoading = true;
  DateTime? initialDeadline;

  TimeOfDay? timeInterview;

  @override
  void initState() {
    super.initState();
    application = widget.initialApplication;
    checkApplicationStatus(application.id!);
  }

  Future<void> checkApplicationStatus(String appId) async {
    try {
      await widget.jobLevel3Controller.checkInterviewExists(appId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to check application status');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateApplicationStatus(
      String status, String currentLevel) async {
    await widget.jobLevel3Controller.updateJobStatus(
      application.id!,
      status,
      currentLevel,
      application.jobId,
    );
    application = (await widget.jobLevel3Controller
        .findApplicationById(application.id!))!;
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
              child: Obx(
                () => Column(
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
                    if (widget.jobLevel3Controller.isScheduled.value)
                      SizedBox(
                        width: 300,
                        child: Txt(
                          title:
                              "Interview scheduled for ${widget.jobLevel3Controller.deadlineController.text} at ${widget.jobLevel3Controller.timeController.text}.",
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
                    if (isButtonPressed &&
                        (application.currentLevel == "3" &&
                            application.applicationStatus == "accepted") &&
                        widget.jobLevel3Controller.isScheduled.value == false)
                      Column(
                        children: [
                          DateTimeField(
                            format: DateFormat("dd-MM-yyyy"),
                            initialValue: initialDeadline ?? DateTime.now(),
                            onShowPicker: ((context, currentValue) async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: currentValue ?? DateTime.now(),
                                firstDate: DateTime(DateTime.now().year),
                                lastDate: DateTime(DateTime.now().year + 1),
                              );
                              if (date != null) {
                                widget.jobLevel3Controller.deadline = date;
                              }
                              return date;
                            }),
                            controller:
                                widget.jobLevel3Controller.deadlineController,
                            readOnly: true,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelText: 'Interview Date',
                                hintText: 'Select Candidate Interview Date',
                                contentPadding: const EdgeInsets.all(0.0),
                                labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? DarkTheme.whiteGreyColor
                                      : LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.w400,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: LightTheme.primaryColor,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                                hintStyle: const TextStyle(
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: LightTheme.primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.RADIUS_4),
                                ),
                                prefixIcon: const Icon(
                                  Icons.event_rounded,
                                  color: LightTheme.primaryColor,
                                )),
                            style: TextStyle(
                              color: isDarkMode
                                  ? DarkTheme.whiteGreyColor
                                  : LightTheme.black,
                            ),
                            validator: ((value) {
                              if (value == null) return 'Please add date';
                              return null;
                            }),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          DateTimeField(
                            format: DateFormat("h:mm a"),
                            onShowPicker: ((context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now(),
                                ),
                              );
                              if (time != null) {
                                widget.jobLevel3Controller.timeInterview = time;
                              }
                              return DateTimeField.convert(time);
                            }),
                            controller:
                                widget.jobLevel3Controller.timeController,
                            readOnly: true,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelText: 'Interview Tiime',
                                hintText: 'Select Candidate Interview Time',
                                contentPadding: const EdgeInsets.all(0.0),
                                labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? DarkTheme.whiteGreyColor
                                      : LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.w400,
                                ),
                                floatingLabelStyle: const TextStyle(
                                  color: LightTheme.primaryColor,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                                hintStyle: const TextStyle(
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: LightTheme.primaryColor,
                                    width: 1,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(Sizes.RADIUS_4),
                                ),
                                prefixIcon: const Icon(
                                  Icons.event_rounded,
                                  color: LightTheme.primaryColor,
                                )),
                            style: TextStyle(
                              color: isDarkMode
                                  ? DarkTheme.whiteGreyColor
                                  : LightTheme.black,
                            ),
                            validator: ((value) {
                              if (value == null) return 'Please add time';
                              return null;
                            }),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomButton(
                            textColor: LightTheme.white,
                            buttonType: ButtonType.loading,
                            isLoading: widget
                                .jobLevel3Controller.isSchedulerLoading.value,
                            loadingWidget: widget.jobLevel3Controller
                                    .isSchedulerLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor: LightTheme.primaryColor,
                                    ),
                                  )
                                : null,
                            color: LightTheme.primaryColor,
                            constraints: const BoxConstraints(
                                maxHeight: 45, minHeight: 45),
                            buttonPadding: const EdgeInsets.all(0),
                            customTextStyle: const TextStyle(
                                fontSize: Sizes.TEXT_SIZE_12,
                                color: LightTheme.white,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.normal),
                            text: "Schedule Candidate Interview",
                            onPressed: () async {
                              var jobLevel3Controller =
                                  widget.jobLevel3Controller;
                              if (jobLevel3Controller.deadline != null &&
                                  jobLevel3Controller.timeInterview != null) {
                                await jobLevel3Controller.scheduleInterview(
                                  application.id!,
                                  jobLevel3Controller.deadline!,
                                  jobLevel3Controller.timeInterview!,
                                );
                              } else {
                                Get.snackbar('Error',
                                    'Please select both date and time');
                              }
                            },
                            hasInfiniteWidth: true,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
