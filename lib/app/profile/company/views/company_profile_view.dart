import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/profile/company/controllers/company_profile_controller.dart';
import 'package:skillsift_flutter_app/core/models/company_model.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/widgets/company_drawer.dart';
import '../../../faqs/views/faqs_screen.dart';
import '../../../notifications/views/notifications_screen.dart';
import '../components/company_details_update_form.dart';
import '../components/company_password_update_form.dart';

class CompanyProfileScreen extends StatelessWidget {
  CompanyProfileScreen({super.key});

  final CompanyProfileController companyProfileController =
      Get.put(CompanyProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        drawer: CompanyDrawer(
          authController: authController,
          companyProfileController: companyProfileController,
        ),
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Obx(() {
            if (companyProfileController.isLoading.value) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: LightTheme.primaryColor,
                  ),
                ),
              );
            } else {
              return Flex(
                direction: Axis.vertical,
                children: [
                  const SizedBox(
                    height: Sizes.HEIGHT_20,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 64,
                            backgroundImage: companyProfileController
                                        .profilePhoto !=
                                    null
                                ? Image.file(
                                        companyProfileController.profilePhoto!)
                                    .image
                                : companyProfileController
                                            .company['profilePhoto'] !=
                                        ""
                                    ? Image.network(companyProfileController
                                            .company['profilePhoto'])
                                        .image
                                    : const NetworkImage(
                                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                            backgroundColor: LightTheme.blackShade4,
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () =>
                                {companyProfileController.pickImage()},
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
                      title: companyProfileController.companyName == ""
                          ? companyProfileController.company['companyName']
                          : companyProfileController.companyName,
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
                    title: companyProfileController.company['contactEmail'],
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_18,
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
                      Get.to(CompanyDetailsUpdateForm(
                        authController: authController,
                        company:
                            Company.fromJson(companyProfileController.company),
                        companyProfileController: companyProfileController,
                      ));
                    },
                    leading: const Icon(
                      Icons.factory,
                      color: LightTheme.secondaryColor,
                    ),
                    title: const Txt(
                      textAlign: TextAlign.left,
                      title: 'Update company details',
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
                      Get.to(UpdateCompanyPassword(
                          profileController: companyProfileController));
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
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
