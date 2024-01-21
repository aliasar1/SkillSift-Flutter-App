import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/controllers/jobs_company_controller.dart';
import 'package:skillsift_flutter_app/core/models/company_model.dart';
import 'package:skillsift_flutter_app/core/widgets/job_card.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/widgets/company_drawer.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../../../profile/company/controllers/company_profile_controller.dart';

class JobAddedByCompanyScreen extends StatelessWidget {
  JobAddedByCompanyScreen({super.key});

  final authController = Get.put(AuthController());

  final companyProfileController = Get.put(CompanyProfileController());
  final jobsController = Get.put(CompanyAddedJobsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(),
        drawer: CompanyDrawer(
          authController: authController,
          companyProfileController: companyProfileController,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Column(children: [
            const Txt(
              textAlign: TextAlign.start,
              title: "Jobs Added",
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontSize: Sizes.TEXT_SIZE_22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Sizes.SIZE_12),
            Obx(() {
              if (jobsController.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.primaryColor,
                    ),
                  ),
                );
              } else if (jobsController.jobList.isEmpty) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.NO_JOB_ADDED,
                        height: Sizes.ICON_SIZE_50 * 4,
                        width: Sizes.ICON_SIZE_50 * 4,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Txt(
                          title: "No jobs added",
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
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: jobsController.jobList.length,
                    itemBuilder: (context, i) {
                      return firebaseAuth.currentUser!.uid ==
                              jobsController.jobList[i].companyId
                          ? JobCard(
                              job: jobsController.jobList[i],
                              company: Company.fromJson(
                                  companyProfileController.company),
                              bookmarkController: null,
                              isCompany: true,
                            )
                          : null;
                    });
              }
            }),
          ]),
        ),
      ),
    );
  }
}
