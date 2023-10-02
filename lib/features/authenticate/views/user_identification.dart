import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/company_signup.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/signup_screen.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class UserIdentificationScreen extends StatelessWidget {
  const UserIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColors.secondaryColorDark),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.work_outline_outlined,
                  color: AppColors.secondaryColorDark,
                  size: Sizes.ICON_SIZE_50 * 3,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Txt(
                  title: "Identify Yourself",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: AppColors.black,
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Txt(
                  title: "How to you want to register yourself as?",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: AppColors.black,
                    fontSize: Sizes.TEXT_SIZE_14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomButton(
                  color: AppColors.secondaryColorDark,
                  hasInfiniteWidth: true,
                  buttonType: ButtonType.text,
                  onPressed: () {
                    Get.offAll(SignupScreen());
                  },
                  text: "Sign up as Job Seeker",
                  constraints:
                      const BoxConstraints(maxHeight: 45, minHeight: 45),
                  buttonPadding: const EdgeInsets.all(0),
                  customTextStyle: const TextStyle(
                      fontSize: Sizes.TEXT_SIZE_12,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal),
                  textColor: AppColors.almondWhite,
                ),
                CustomButton(
                  color: AppColors.secondaryColorDark,
                  hasInfiniteWidth: true,
                  buttonType: ButtonType.text,
                  onPressed: () {
                    Get.offAll(CompanySignupScreen());
                  },
                  text: "Register your company",
                  constraints:
                      const BoxConstraints(maxHeight: 45, minHeight: 45),
                  buttonPadding: const EdgeInsets.all(0),
                  customTextStyle: const TextStyle(
                      fontSize: Sizes.TEXT_SIZE_12,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal),
                  textColor: AppColors.almondWhite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
