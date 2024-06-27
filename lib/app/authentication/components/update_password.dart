import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';
import '../views/login.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key, required this.token});

  final controller = Get.put(AuthController());
  final String token;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
            child: Form(
              key: controller.updatePasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    isDarkMode ? AppAssets.APP_ICON_DARK : AppAssets.APP_ICON,
                    height: Sizes.ICON_SIZE_50 * 1.8,
                    width: Sizes.ICON_SIZE_50 * 1.8,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Txt(
                    title: "Reset your password",
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
                    title: "Please fill these fields to reset your password",
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
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.passController,
                      labelText: 'New Password',
                      autofocus: false,
                      hintText: 'New Password',
                      obscureText: controller.isObscure.value,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      prefixIconData: Icons.vpn_key_rounded,
                      suffixIconData: controller.isObscure.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      onSuffixTap: controller.toggleVisibility,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                          return "Password must contain at least one lowercase letter";
                        } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          return "Password must contain at least one uppercase letter";
                        } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          return "Password must contain at least one digit";
                        } else if (!RegExp(r'(?=.*[@$!%*?&])')
                            .hasMatch(value)) {
                          return "Password must contain at least one special character";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.confirmPassController,
                      labelText: "Confirm New Password",
                      autofocus: false,
                      hintText: AppStrings.PASSWORD,
                      obscureText: controller.isObscure1.value,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      prefixIconData: Icons.vpn_key_rounded,
                      suffixIconData: controller.isObscure1.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      onSuffixTap: controller.toggleVisibility1,
                      onFieldSubmit: (_) async {
                        await controller.resetPassword(
                            token, controller.passController.text.trim());
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value != controller.passController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      isLoading: controller.isLoading.value,
                      buttonType: ButtonType.loading,
                      loadingWidget: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: LightTheme.primaryColor,
                              ),
                            )
                          : null,
                      onPressed: () async {
                        await controller.resetPassword(
                            token, controller.passController.text.trim());
                      },
                      text: "Reset",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        fontContainerWidth: 160,
                        title: "I don't want to reset?",
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
                          Get.offAll(LoginScreen());
                        },
                        child: const Txt(
                          title: "Go to Login",
                          fontContainerWidth: 85,
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
