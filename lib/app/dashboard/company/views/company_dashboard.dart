import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/widgets/company_drawer.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../components/add_recruiter_screen.dart';
import '../components/recruiter_card.dart';
import '../controllers/profile_controller.dart';
import '../controllers/recruiter_controller.dart';

class CompanyDashboard extends StatelessWidget {
  CompanyDashboard({super.key});

  final authController = Get.put(AuthController());
  final profileController = Get.put(ProfileController());
  final recruiterController = Get.put(RecruiterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        drawer: CompanyDrawer(
          authController: authController,
          profileController: profileController,
        ),
        appBar: AppBar(),
        body: Column(
          children: [
            Obx(
              () {
                if (profileController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.whiteShade2,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Sizes.MARGIN_16),
                        child: Column(
                          children: [
                            Txt(
                              textAlign: TextAlign.start,
                              title:
                                  'Hello ${profileController.user['companyName']}! 👋',
                              fontContainerWidth: double.infinity,
                              textStyle: const TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.secondaryColor,
                                fontSize: Sizes.TEXT_SIZE_22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Sizes.HEIGHT_10),
                            const Txt(
                              textAlign: TextAlign.start,
                              title: "Welcome To Company Dashboard",
                              fontContainerWidth: double.infinity,
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.primaryColor,
                                fontSize: Sizes.TEXT_SIZE_16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Sizes.HEIGHT_18),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Obx(() {
              if (recruiterController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.primaryColor,
                    ),
                  ),
                );
              } else if (recruiterController.recruiters.isEmpty) {
                return Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.NO_RECRUITER_ADDED,
                          height: Sizes.ICON_SIZE_50 * 6,
                          width: Sizes.ICON_SIZE_50 * 6,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Txt(
                            title: "No recruiters are added yet!",
                            fontContainerWidth: double.infinity,
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.secondaryColor,
                              fontSize: Sizes.TEXT_SIZE_16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.HEIGHT_160),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                  child: Column(
                    children: [
                      const CustomSearchWidget(
                        label: 'Search recruiters here...',
                      ),
                      const SizedBox(height: Sizes.HEIGHT_16),
                      ListView.builder(
                        itemCount: recruiterController.recruiters.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final recruiter =
                              recruiterController.recruiters[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: RecruiterCard(
                              recruiter: recruiter,
                              controller: recruiterController,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            recruiterController.clearFields();
            Get.to(AddRecruiterScreen(
              isEdit: false,
              controller: recruiterController,
            ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.person_add,
            color: LightTheme.white,
          ),
        ),
      ),
    );
  }
}
