import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';

Future<dynamic> verifyDialog(AuthController controller) {
  return Get.dialog(
    AlertDialog(
      backgroundColor: LightTheme.white,
      title: const Txt(
        textAlign: TextAlign.start,
        title: "Verify your email",
        fontContainerWidth: 100,
        textStyle: TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.black,
          fontSize: Sizes.TEXT_SIZE_18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Txt(
        textAlign: TextAlign.start,
        title: "An email is sent to you, please verify your account.",
        fontContainerWidth: double.infinity,
        textStyle: TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.black,
          fontSize: Sizes.TEXT_SIZE_14,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Txt(
            title: "Back",
            fontContainerWidth: 100,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: Color.fromARGB(255, 13, 40, 47),
              fontSize: Sizes.TEXT_SIZE_14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(LightTheme.primaryColor)),
          onPressed: () async {
            try {
              await firebaseAuth.currentUser!.sendEmailVerification();
              Get.back();
              Get.snackbar(
                'Email Sent',
                'Verification email has been sent.',
              );
            } catch (e) {
              Get.back();
              Get.snackbar(
                'Error',
                'Failed to send email verification: $e',
              );
            }
          },
          child: const Txt(
            title: "Resend Email",
            fontContainerWidth: 100,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontSize: Sizes.TEXT_SIZE_14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
