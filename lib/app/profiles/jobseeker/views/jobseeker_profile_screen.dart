import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/profiles/jobseeker/components/update_jobseeker_details.dart';
import 'package:skillsift_flutter_app/app/profiles/jobseeker/components/update_jobseeker_pass.dart';
import 'package:skillsift_flutter_app/core/widgets/mode_switch.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../faqs/views/faqs_screen.dart';
import '../../../notifications/views/notifcations_screen.dart';
import '../controllers/jobseeker_profile_controller.dart';

class JobseekerProfileScreen extends StatelessWidget {
  JobseekerProfileScreen({super.key});

  final profileController = Get.put(JobseekerProfileController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      body: Obx(
        () {
          if (profileController.isLoading.value) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_12,
              vertical: Sizes.MARGIN_12,
            ),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: profileController.profilePhoto != null
                            ? Image.file(profileController.profilePhoto!).image
                            : profileController.jobseeker.profilePicUrl != ""
                                ? NetworkImage(
                                    profileController.jobseeker.profilePicUrl)
                                : const NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                        backgroundColor: LightTheme.blackShade4,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () => {profileController.pickProfile()},
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: LightTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                Obx(
                  () => Txt(
                    textAlign: TextAlign.center,
                    title: profileController.userName == ""
                        ? profileController.jobseeker.fullname
                        : profileController.userName,
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: isDarkMode
                          ? DarkTheme.whiteGreyColor
                          : LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_8,
                ),
                Txt(
                  textAlign: TextAlign.center,
                  title: profileController.jobseeker.email,
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
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                ListTile(
                  onTap: () {
                    Get.to(UpdateJobseekerDetailsForm(
                        jobseekerProfileController: profileController,
                        jobseeker: profileController.jobseeker));
                  },
                  leading: Icon(
                    Icons.person,
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.secondaryColor,
                  ),
                  title: Txt(
                    textAlign: TextAlign.left,
                    title: 'Update jobseeker details',
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
                ListTile(
                  onTap: () {
                    Get.to(UpdateJobseekerPass(
                        profileController: profileController,
                        jobseeker: profileController.jobseeker));
                  },
                  leading: Icon(
                    Icons.lock,
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.secondaryColor,
                  ),
                  title: Txt(
                    textAlign: TextAlign.left,
                    title: 'Update password',
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
                ListTile(
                  onTap: () {
                    Get.to(const NotificationsScreen());
                  },
                  leading: Icon(
                    Icons.notifications,
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.secondaryColor,
                  ),
                  title: Txt(
                    textAlign: TextAlign.left,
                    title: 'Notifications',
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
                ListTile(
                  onTap: () {
                    Get.to(const FaqsScreen());
                  },
                  leading: Icon(
                    Icons.question_mark,
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.secondaryColor,
                  ),
                  title: Txt(
                    textAlign: TextAlign.left,
                    title: 'FAQs',
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
                const Row(
                  children: [
                    Spacer(),
                    ModeSwitch(),
                    Spacer(),
                  ],
                ),
                const Spacer(),
                Txt(
                  textAlign: TextAlign.center,
                  title: 'Powered By SkillSift ©',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
