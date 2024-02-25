import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:skillsift_flutter_app/app/authentication/components/update_password.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.email});

  final String email;
  final controller = Get.put(AuthController());

  final defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: const TextStyle(
      fontSize: 20,
      color: LightTheme.primaryColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: LightTheme.primaryColor),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
          iconTheme: const IconThemeData(color: LightTheme.primaryColor),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsetsDirectional.symmetric(
                  vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    AppAssets.APP_ICON,
                    height: Sizes.ICON_SIZE_50 * 1.8,
                    width: Sizes.ICON_SIZE_50 * 1.8,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Txt(
                    title: "OTP Verification",
                    fontContainerWidth: double.infinity,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Txt(
                    title: "Enter the code sent to the email",
                    fontContainerWidth: double.infinity,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Txt(
                    title: email,
                    fontContainerWidth: double.infinity,
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Pinput(
                    length: 6,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: LightTheme.primaryColor),
                      ),
                    ),
                    defaultPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: LightTheme.greyShade8),
                      ),
                    ),
                    closeKeyboardWhenCompleted: true,
                    controller: controller.otpController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(
                    () => SizedBox(
                      width: 280,
                      child: CustomButton(
                        color: LightTheme.primaryColor,
                        hasInfiniteWidth: false,
                        buttonType: ButtonType.loading,
                        isLoading: controller.isLoading.value,
                        loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: LightTheme.primaryColor,
                                ),
                              )
                            : null,
                        onPressed: () async {
                          var resp = await controller
                              .verifyOTP(controller.otpController.text);
                          if (resp) {
                            Get.to(UpdatePasswordScreen(
                              token: controller.otpController.text,
                            ));
                          }
                        },
                        text: "Verify",
                        constraints:
                            const BoxConstraints(maxHeight: 45, minHeight: 45),
                        buttonPadding: const EdgeInsets.all(0),
                        customTextStyle: const TextStyle(
                            fontSize: Sizes.TEXT_SIZE_12,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                        textColor: LightTheme.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Txt(
                        fontContainerWidth: 150,
                        title: "Didn't receive code?",
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          controller.otpController.clear;
                          await controller.resendOTPEmail(email);
                        },
                        child: const Txt(
                          title: "Resend",
                          fontContainerWidth: 60,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: LightTheme.primaryColor,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
