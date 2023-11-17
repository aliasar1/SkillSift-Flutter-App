import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/controllers/profile_controller.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import 'recruiters_screen.dart';

class CompanyDashboard extends StatelessWidget {
  CompanyDashboard({super.key});

  final authController = Get.put(AuthController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Obx(() {
          if (profileController.isLoading.value) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Txt(
                      // title: "Hello ${profileController.user['companyName']}",
                      title: "Hello",
                      fontContainerWidth: double.infinity,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.secondaryColor,
                        fontSize: Sizes.TEXT_SIZE_22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.textWithImage,
                      onPressed: () {
                        Get.to(RecruiterScreen());
                      },
                      image: const Icon(
                        Icons.group,
                        color: LightTheme.white,
                      ),
                      text: "Manage Recruiters",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_12,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.textWithImage,
                      onPressed: () {},
                      image: const Icon(
                        Icons.account_box,
                        color: LightTheme.white,
                      ),
                      text: "Manage Jobs",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_12,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
