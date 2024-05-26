import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/recruiter/views/recruiter_dashboard.dart';
import 'package:skillsift_flutter_app/core/widgets/mode_switch.dart';
import '../../app/authentication/views/login.dart';
import '../../app/notifications/views/notifcations_screen.dart';
import '../../app/profiles/recruiter/views/recruiter_profile_screen.dart';
import '../exports/constants_exports.dart';
import '../exports/widgets_export.dart';
import '../models/recruiter_model.dart';

class RecruiterDrawer extends StatelessWidget {
  const RecruiterDrawer({
    super.key,
    required this.recruiter,
    required this.controller,
  });

  final Recruiter recruiter;
  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: LightTheme.secondaryColor,
              backgroundImage: recruiter.profilePicUrl == ""
                  ? const NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
                  : NetworkImage(
                      recruiter.profilePicUrl,
                    ),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Txt(
              title: recruiter.fullname,
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
            const SizedBox(height: 5),
            Txt(
              title: recruiter.email,
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
            const SizedBox(height: 10),
            const Divider(),
            buildDrawerTile(
              "Profile",
              Icons.person,
              () {
                Get.offAll(RecruiterProfileScreen(
                  recruiter: recruiter,
                ));
              },
              isDarkMode,
            ),
            buildDrawerTile(
              "Dashboard",
              Icons.work,
              () {
                Get.offAll(RecruiterDashboard(
                  recruiter: recruiter,
                ));
              },
              isDarkMode,
            ),
            buildDrawerTile(
              "Notifications",
              Icons.notifications,
              () {
                Get.to(const NotificationsScreen());
              },
              isDarkMode,
            ),
            buildDrawerTile(
              "History",
              Icons.history,
              () {},
              isDarkMode,
            ),
            buildDrawerTile(
              "Logout",
              Icons.logout,
              () {
                buildLogoutDialog(context);
              },
              isDarkMode,
            ),
            const Spacer(),
            const ModeSwitch(),
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
              controller.logout();
              controller.dispose();
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

  ListTile buildDrawerTile(
      String text, IconData icon, Function onPressed, bool isDarkMode) {
    return ListTile(
      title: Txt(
        title: text,
        textAlign: TextAlign.start,
        textStyle: TextStyle(
          fontFamily: "Poppins",
          color:
              isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.secondaryColor,
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
