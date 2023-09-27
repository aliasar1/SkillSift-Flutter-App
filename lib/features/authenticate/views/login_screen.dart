import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.work_outline_outlined,
                color: AppColors.secondaryColorDark,
                size: Sizes.ICON_SIZE_50 * 3,
              ),
              Txt(
                title: "Login to your Account",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.secondaryColorDark,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Txt(
                title: "Welcome back, please enter your details",
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.secondaryColorDark,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
