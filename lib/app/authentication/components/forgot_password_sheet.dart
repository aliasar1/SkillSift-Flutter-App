import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  height: Get.height * 0.45,
                  decoration: const BoxDecoration(
                    color: LightTheme.whiteShade2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Txt(
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            title: 'Forgot Password',
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.black,
                              fontSize: Sizes.TEXT_SIZE_20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Txt(
                            textAlign: TextAlign.start,
                            fontContainerWidth: double.infinity,
                            title:
                                'Enter your email for the verification process, we will send you a reset password email to the provided email address.',
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.black,
                              fontSize: Sizes.TEXT_SIZE_14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
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
                          controller.resetPassword(
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
                          onPressed: () {
                            controller.resetPassword(
                                controller.resetEmailController.text.trim());
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
      child: const SizedBox(
        width: 120,
        child: Txt(
          textAlign: TextAlign.end,
          title: "Forgot Password?",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
