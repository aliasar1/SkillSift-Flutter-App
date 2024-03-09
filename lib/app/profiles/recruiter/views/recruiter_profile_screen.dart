import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';
import 'package:skillsift_flutter_app/core/widgets/recruiter_drawer.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../../../faqs/views/faqs_screen.dart';
import '../../../notifications/views/notifcations_screen.dart';
import '../components/update_recruiter_info.dart';
import '../components/update_recruiter_pass.dart';
import '../controllers/recruiter_profile_controller.dart';

class RecruiterProfileScreen extends StatelessWidget {
  RecruiterProfileScreen({super.key, required this.recruiter});

  final Recruiter recruiter;

  final authController = Get.put(AuthController());
  final recruiterProfileController = Get.put(RecruiterProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
        ),
        drawer:
            RecruiterDrawer(recruiter: recruiter, controller: authController),
        body: Container(
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
                      backgroundImage: recruiterProfileController
                                  .profilePhoto !=
                              null
                          ? Image.file(recruiterProfileController.profilePhoto!)
                              .image
                          : recruiter.profilePicUrl != ""
                              ? NetworkImage(recruiter.profilePicUrl)
                              : const NetworkImage(
                                  'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                      backgroundColor: LightTheme.blackShade4,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () =>
                            {recruiterProfileController.pickProfile()},
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
                  title: recruiterProfileController.userName == ""
                      ? recruiter.fullname
                      : recruiterProfileController.userName,
                  fontContainerWidth: double.infinity,
                  textStyle: const TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
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
                title: recruiter.email,
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.secondaryColor,
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
                  Get.to(UpdateRecruiterDetailsForm(
                    recruiterProfileController: recruiterProfileController,
                    recruiter: recruiter,
                  ));
                },
                leading: const Icon(
                  Icons.person,
                  color: LightTheme.secondaryColor,
                ),
                title: const Txt(
                  textAlign: TextAlign.left,
                  title: 'Update recruiter details',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(UpdateRecruiterPass(
                      profileController: recruiterProfileController,
                      recruiter: recruiter));
                },
                leading: const Icon(
                  Icons.lock,
                  color: LightTheme.secondaryColor,
                ),
                title: const Txt(
                  textAlign: TextAlign.left,
                  title: 'Update password',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(const NotificationsScreen());
                },
                leading: const Icon(
                  Icons.notifications,
                  color: LightTheme.secondaryColor,
                ),
                title: const Txt(
                  textAlign: TextAlign.left,
                  title: 'Notifications',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(const FaqsScreen());
                },
                leading: const Icon(
                  Icons.question_mark,
                  color: LightTheme.secondaryColor,
                ),
                title: const Txt(
                  textAlign: TextAlign.left,
                  title: 'FAQs',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const Spacer(),
              const Txt(
                textAlign: TextAlign.center,
                title: 'Powered By SkillSift ©',
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
