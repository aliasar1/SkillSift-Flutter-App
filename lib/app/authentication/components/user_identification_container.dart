import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../views/signup.dart';

class UserIdentificationContainer extends StatelessWidget {
  const UserIdentificationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              LightTheme.primaryColor,
              LightTheme.secondaryColor,
            ],
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Sizes.RADIUS_40),
              topRight: Radius.circular(Sizes.RADIUS_40)),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Txt(
                title: "Identify Yourself",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.white,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Txt(
                title: "How to you want to register yourself as?",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.whiteShade2,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              CustomButton(
                color: LightTheme.white,
                hasInfiniteWidth: true,
                buttonType: ButtonType.text,
                onPressed: () {
                  Get.to(SignupScreen(
                    isRecruiter: false,
                  ));
                },
                text: "Sign up as Job Seeker",
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
                buttonPadding: const EdgeInsets.all(0),
                customTextStyle: const TextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: LightTheme.primaryColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
                textColor: LightTheme.primaryColor,
              ),
              CustomButton(
                color: LightTheme.white,
                hasInfiniteWidth: true,
                buttonType: ButtonType.text,
                onPressed: () {
                  Get.to(SignupScreen(
                    isRecruiter: true,
                  ));
                },
                text: "Sign up as Recruiter",
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
                buttonPadding: const EdgeInsets.all(0),
                customTextStyle: const TextStyle(
                    fontSize: Sizes.TEXT_SIZE_14,
                    color: LightTheme.primaryColor,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
                textColor: LightTheme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
