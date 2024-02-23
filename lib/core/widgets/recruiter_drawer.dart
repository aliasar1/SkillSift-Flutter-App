import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/app/dashboard/recruiter/views/recuiter_dashboard.dart';
import '../../app/authentication/views/login.dart';
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
              textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Txt(
              title: recruiter.email,
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
            buildDrawerTile("Profile", Icons.person, () {
              // Get.offAll(RecruiterProfileScreen());
            }),
            buildDrawerTile("Jobs", Icons.work, () {
              Get.offAll(RecruiterDashboard());
            }),
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
              controller.logout();
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
