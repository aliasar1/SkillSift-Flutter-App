import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../views/login_screen.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        Get.offAll(LoginScreen());
      },
      color: AppColors.secondaryColorDark,
      textColor: AppColors.white,
      text: "GET STARTED",
      customTextStyle:
          const TextStyle(fontSize: Sizes.TEXT_SIZE_18, color: Colors.white),
      hasInfiniteWidth: true,
    );
  }
}
