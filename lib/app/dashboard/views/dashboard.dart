import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:skillsift_flutter_app/core/widgets/custom_search.dart';

import '../../../core/constants/assets.dart';
import '../../../core/exports/constants_exports.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key});

  final controller = AuthController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          leadingWidth: 180,
          leading: Container(
            margin: const EdgeInsets.only(left: 20, top: 15),
            child: ClipRect(
              child: Image.asset(
                AppAssets.APP_TEXT,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            const Icon(
              Icons.mail,
              size: 30,
              color: LightTheme.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.notifications,
              size: 30,
              color: LightTheme.primaryColor,
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                buildLogoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                size: 30,
                color: LightTheme.primaryColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: ListView(
            children: [
              const CustomSearchWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Job Feed',
                style: TextStyle(
                    color: LightTheme.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Jobs based on your skills',
                style: TextStyle(
                    color: LightTheme.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    margin:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                      color: LightTheme.cardLightShade,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
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
                                  Spacer(),
                                  Icon(Icons.bookmark_outline),
                                ],
                              ),
                              Txt(
                                title: "Systems Ltd",
                                textAlign: TextAlign.start,
                                fontContainerWidth: double.infinity,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.secondaryColor,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Txt(
                                title: "Karachi",
                                textAlign: TextAlign.start,
                                fontContainerWidth: double.infinity,
                                textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: LightTheme.secondaryColor,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Txt(
                            title: "Rs 50000 - Rs 80000 a month    Full Time",
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.blackShade4,
                              fontSize: Sizes.TEXT_SIZE_16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.send,
                                    color: LightTheme.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Txt(
                                    title: "Easy Apply",
                                    textAlign: TextAlign.start,
                                    fontContainerWidth: 120,
                                    textStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      color: LightTheme.secondaryColor,
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timeline,
                                    color: LightTheme.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Txt(
                                    title: "Urgently Hiring",
                                    textAlign: TextAlign.start,
                                    fontContainerWidth: 150,
                                    textStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      color: LightTheme.secondaryColor,
                                      fontSize: Sizes.TEXT_SIZE_16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Txt(
                            title: "Posted 5 days ago",
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.black,
                              fontSize: Sizes.TEXT_SIZE_14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildLogoutDialog(BuildContext context) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: LightTheme.white,
        title: const Text(
          'Confirm Logout',
          style: TextStyle(
            color: LightTheme.black,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: LightTheme.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: LightTheme.primaryColor),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LightTheme.primaryColor),
            ),
            onPressed: () async {
              controller.logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: LightTheme.white),
            ),
          ),
        ],
      ),
    );
  }
}
