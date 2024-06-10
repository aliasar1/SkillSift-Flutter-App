import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';
import '../views/user_identification.dart';
import 'forgot_password_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isDarkMode ? AppAssets.APP_ICON_DARK : AppAssets.APP_ICON,
              height: Sizes.ICON_SIZE_50 * 1.6,
              width: Sizes.ICON_SIZE_50 * 3,
            ),
            Image.asset(
              isDarkMode ? AppAssets.APP_TEXT_DARK : AppAssets.APP_TEXT,
              height: Sizes.ICON_SIZE_50 * 2,
              width: Sizes.ICON_SIZE_50 * 4,
            ),
            Txt(
              title: "Login to your Account",
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: isDarkMode
                    ? DarkTheme.whiteGreyColor
                    : LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Txt(
              title: "Welcome back, please enter your details",
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: isDarkMode
                    ? DarkTheme.primaryColor
                    : LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              controller: controller.emailController,
              labelText: AppStrings.EMAIL_ADDRESS,
              autofocus: false,
              hintText: "abc@gmail.com",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIconData: Icons.email,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email cannot be empty";
                } else if (!GetUtils.isEmail(value)) {
                  return "Invalid email format";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => CustomTextFormField(
                controller: controller.passController,
                labelText: AppStrings.PASSWORD,
                autofocus: false,
                hintText: AppStrings.PASSWORD,
                obscureText: controller.isObscure.value,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                prefixIconData: Icons.vpn_key_rounded,
                suffixIconData: controller.isObscure.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
                onFieldSubmit: (_) async {
                  await controller.loginUser(
                      email: controller.emailController.text.trim(),
                      password: controller.passController.text.trim());
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 24.0,
                        width: 28.0,
                        child: Checkbox(
                          activeColor: LightTheme.primaryColor,
                          value: controller.isChecked.value,
                          onChanged: (newValue) {
                            controller.toggleIsChecked();
                          },
                        ),
                      ),
                    ),
                    Txt(
                      title: "Remember me?",
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: isDarkMode
                            ? DarkTheme.whiteGreyColor
                            : LightTheme.black,
                        fontSize: Sizes.TEXT_SIZE_12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                ForgotPasswordSheet(controller: controller),
              ],
            ),
            const SizedBox(
              height: 20,
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
                  await controller.loginUser(
                      email: controller.emailController.text.trim(),
                      password: controller.passController.text.trim());
                  // if (isValid) {
                  //   if (!firebaseAuth.currentUser!.emailVerified) {
                  //     await controller.removeLoginToken();
                  //     await controller.removeToken();
                  //     verifyDialog(controller);
                  //   } else {
                  //     final type = controller.getUserType();
                  //     if (type == 'companies') {
                  //       controller.clearFields();
                  //       Get.offAll(CompanyDashboard());
                  //     } else if (type == 'jobseekers') {
                  //       controller.clearFields();
                  //       Get.offAll(DashboardScreen());
                  //     } else {
                  //       controller.clearFields();
                  //       Get.offAll(RecruiterDashboard());
                  //     }
                  //   }
                  // }
                },
                text: "Login",
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
                buttonPadding: const EdgeInsets.all(0),
                customTextStyle: const TextStyle(
                    fontSize: Sizes.TEXT_SIZE_12,
                    color: LightTheme.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal),
                textColor: LightTheme.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Txt(
                  fontContainerWidth: 180,
                  title: "Don't have an account?",
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: isDarkMode
                        ? DarkTheme.whiteGreyColor
                        : LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.loginFormKey.currentState?.reset();
                    controller.clearFields();
                    Get.to(const UserIdentificationScreen());
                  },
                  child: const Txt(
                    title: "Sign Up",
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
    );
  }
}
