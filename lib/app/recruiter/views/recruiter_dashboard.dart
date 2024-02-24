import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/company_signup.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/widgets/recruiter_drawer.dart';
import '../../authentication/controllers/auth_controller.dart';

class RecruiterDashboard extends StatefulWidget {
  RecruiterDashboard({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
          actions: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: LightTheme.secondaryColor,
                  backgroundImage: widget.recruiter.profilePicUrl == ""
                      ? const NetworkImage(
                          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
                      : NetworkImage(
                          widget.recruiter.profilePicUrl,
                        ),
                  radius: 25,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      widget.recruiter.companyId == null
                          ? Icons.warning
                          : Icons.check_circle,
                      color: widget.recruiter.companyId == null
                          ? Colors.red
                          : Colors.green,
                      size: 22,
                    )),
              ],
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
          ],
        ),
        drawer: RecruiterDrawer(
            recruiter: widget.recruiter, controller: controller),
        body: widget.recruiter.companyId == null &&
                (controller.getSkipFlag() == null || !controller.getSkipFlag()!)
            ? Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: LightTheme.grey,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: LightTheme.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: const Icon(Icons.warning,
                            color: Colors.white, size: 100),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_24),
                      const Txt(
                        title: "Account Activation Required",
                        textAlign: TextAlign.center,
                        fontContainerWidth: 260,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_18),
                      const Txt(
                        title:
                            "Please complete your company details in order to activate your account.",
                        textAlign: TextAlign.center,
                        fontContainerWidth: 280,
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.black,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.setSkipFlag(true);
                              setState(() {});
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(LightTheme.white),
                              foregroundColor: MaterialStateProperty.all(
                                  LightTheme.primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            child: const Text('Skip'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(CompanySignupScreen(
                                recruiter: widget.recruiter,
                              ));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  LightTheme.primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(LightTheme.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                            child: const Text('Complete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
                child: Column(
                  children: [
                    Txt(
                      textAlign: TextAlign.start,
                      title: 'Hello ${widget.recruiter.fullname}! 👋',
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
                      title: "Welcome To Recruiter Dashboard",
                      fontContainerWidth: double.infinity,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.primaryColor,
                        fontSize: Sizes.TEXT_SIZE_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Sizes.HEIGHT_18),
                    CustomSearchWidget(
                      label: 'Search added jobs here...',
                      onFieldSubmit: (val) {
                        // searchController.searchJob(val, jobController);
                      },
                    ),
                    const SizedBox(height: Sizes.HEIGHT_18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 6),
                      height: 165,
                      decoration: BoxDecoration(
                        color: LightTheme.cardLightShade,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            children: [
                              Txt(
                                title: "Flutter Developer",
                                textAlign: TextAlign.start,
                                fontContainerWidth: 260,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Txt(
                                title: "Remote",
                                textAlign: TextAlign.start,
                                fontContainerWidth: 260,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: Sizes.HEIGHT_18),
                              Txt(
                                title: "\$1500 - \$2200 Salary Offered",
                                textAlign: TextAlign.start,
                                fontContainerWidth: 260,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: Sizes.HEIGHT_18),
                              Txt(
                                title: "Posted 12 Days Ago",
                                textAlign: TextAlign.start,
                                fontContainerWidth: 260,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.black,
                                  fontSize: Sizes.TEXT_SIZE_14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: LightTheme.primaryColor,
                                    width: 5.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: LightTheme.primaryColor,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: Sizes.HEIGHT_18),
                              Chip(
                                color: MaterialStateProperty.all(Colors.green),
                                label: const Txt(
                                  title: "Active",
                                  textAlign: TextAlign.start,
                                  fontContainerWidth: 40,
                                  textStyle: TextStyle(
                                    fontFamily: "Poppins",
                                    color: LightTheme.black,
                                    fontSize: Sizes.TEXT_SIZE_12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: widget.recruiter.companyId == null
            ? null
            : FloatingActionButton(
                onPressed: () {
                  // jobController.clearFields();
                  // Get.to(AddJobScreen(
                  //   isEdit: false,
                  //   jobController: jobController,
                  // ));
                },
                backgroundColor: LightTheme.primaryColor,
                child: const Icon(
                  Icons.post_add,
                  color: LightTheme.white,
                ),
              ),
      ),
    );
  }
}
