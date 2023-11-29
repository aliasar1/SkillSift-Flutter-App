import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../../../authentication/views/login.dart';
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
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
          actions: [
            IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
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
                            const SizedBox(height: Sizes.HEIGHT_14),
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
                        const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.NO_RECRUITER_ADDED,
                          height: Sizes.ICON_SIZE_50 * 2,
                          width: Sizes.ICON_SIZE_50 * 4,
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
                              fontSize: Sizes.TEXT_SIZE_22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Sizes.MARGIN_12,
                    horizontal: Sizes.MARGIN_8,
                  ),
                  child: ListView.builder(
                    itemCount: recruiterController.recruiters.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final recruiter = recruiterController.recruiters[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: RecruiterCard(
                          recruiter: recruiter,
                          controller: recruiterController,
                        ),
                      );
                    },
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

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({
    super.key,
    required this.authController,
    required this.profileController,
  });

  final AuthController authController;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: LightTheme.secondaryColor,
              // backgroundImage: profileController.user['profilePhoto'] == ""
              //   ? const NetworkImage(
              //       'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
              //   : NetworkImage(
              //       profileController.user['profilePhoto'],
              //     ),
              backgroundImage: NetworkImage(
                  'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Txt(
              title: profileController.user['companyName'],
              textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Txt(
              title: profileController.user['contactEmail'],
              fontContainerWidth: double.infinity,
              textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            buildDrawerTile("Profile", Icons.person, () {}),
            buildDrawerTile("Jobs", Icons.work, () {}),
            buildDrawerTile("Recruiters", Icons.group, () {}),
            buildDrawerTile("Logout", Icons.logout, () {
              buildLogoutDialog(context);
            }),
            const Spacer(),
            Switch(value: false, onChanged: (_) {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildLogoutDialog(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
              style: TextStyle(
                color: LightTheme.primaryColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LightTheme.primaryColor),
            ),
            onPressed: () async {
              authController.logout();
              Get.offAll(LoginScreen());
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: LightTheme.whiteShade1),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildDrawerTile(String text, IconData icon, Function onPressed) {
    return ListTile(
      title: Txt(
        title: text,
        textAlign: TextAlign.start,
        textStyle: const TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.secondaryColor,
          fontSize: Sizes.TEXT_SIZE_16,
          fontWeight: FontWeight.normal,
        ),
      ),
      leading: Icon(
        icon,
        color: LightTheme.primaryColor,
      ),
      onTap: () => onPressed(),
    );
  }
}
