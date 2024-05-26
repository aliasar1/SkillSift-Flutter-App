import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/otp_screen.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordSheet extends StatelessWidget {
  const ForgotPasswordSheet({
    super.key,
    required this.controller,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: controller.resetPasswordFormKey,
                child: Container(
                  width: double.infinity,
                  height: Get.height * 0.38,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? DarkTheme.containerColor
                        : LightTheme.whiteShade2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Txt(
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            title: 'Forgot Password',
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: isDarkMode
                                  ? DarkTheme.whiteGreyColor
                                  : LightTheme.black,
                              fontSize: Sizes.TEXT_SIZE_20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Txt(
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            title:
                                'Enter your email for the verification process, we will send you OTP to the provided email address.',
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: isDarkMode
                                  ? DarkTheme.whiteGreyColor
                                  : LightTheme.black,
                              fontSize: Sizes.TEXT_SIZE_14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: controller.resetEmailController,
                        labelText: AppStrings.EMAIL_ADDRESS,
                        autofocus: false,
                        hintText: "abc@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        prefixIconData: Icons.email,
                        onFieldSubmit: (_) {
                          controller.resetPasswordEmail(
                              controller.resetEmailController.text.trim());
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Invalid email format";
                          }
                          return null;
                        },
                      ),
                      Obx(
                        () => CustomButton(
                          color: LightTheme.primaryColor,
                          hasInfiniteWidth: true,
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
                            final isValid = await controller.resetPasswordEmail(
                                controller.resetEmailController.text.trim());
                            if (isValid) {
                              Get.to(OtpScreen(
                                  email: controller.resetEmailController.text
                                      .trim()));
                            } else {}
                          },
                          text: "Send Email",
                          constraints: const BoxConstraints(
                              maxHeight: 45, minHeight: 45),
                          buttonPadding: const EdgeInsets.all(0),
                          customTextStyle: const TextStyle(
                              fontSize: Sizes.TEXT_SIZE_14,
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                          textColor: LightTheme.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).whenComplete(() => controller.resetEmailController.clear());
      },
      child: SizedBox(
        width: 120,
        child: Txt(
          textAlign: TextAlign.end,
          title: "Forgot Password?",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
