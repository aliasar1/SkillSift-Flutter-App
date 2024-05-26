import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';
import '../views/login.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.controller,
    required this.isRecruiter,
  });

  final AuthController controller;
  final bool isRecruiter;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Form(
      key: controller.signupUserFormKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
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
              title: "Create an Account",
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
              title: "Signup now to get started with your account",
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
              height: 20,
            ),
            CustomTextFormField(
              controller: controller.nameController,
              labelText: AppStrings.NAME,
              autofocus: false,
              hintText: "",
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              prefixIconData: Icons.email,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Name cannot be empty";
                } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                  return "Name must contain only alphabetic characters.";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: controller.emailController,
              labelText: AppStrings.EMAIL_ADDRESS,
              autofocus: false,
              hintText: "abc@gmail.com",
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
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
            CustomTextFormField(
              controller: controller.contactNumberController,
              labelText: "Contact Number",
              autofocus: false,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              prefixIconData: Icons.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Number cannot be empty";
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
                  } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
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
                labelText: "Confirm Password",
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
                onFieldSubmit: (_) {
                  controller.signUp(
                      email: controller.emailController.text.trim(),
                      password: controller.passController.text.trim(),
                      confirmPassword:
                          controller.confirmPassController.text.trim(),
                      name: controller.nameController.text.trim(),
                      contactNumber:
                          controller.contactNumberController.text.trim(),
                      isRecruiter: isRecruiter);
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
              height: 8,
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
                onPressed: () {
                  controller.signUp(
                      email: controller.emailController.text.trim(),
                      password: controller.passController.text.trim(),
                      confirmPassword:
                          controller.confirmPassController.text.trim(),
                      name: controller.nameController.text.trim(),
                      contactNumber:
                          controller.contactNumberController.text.trim(),
                      isRecruiter: isRecruiter);
                },
                text: "Sign Up",
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Txt(
                  fontContainerWidth: 200,
                  title: "Already have an account?",
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
                    controller.clearFields();
                    Get.offAll(LoginScreen());
                  },
                  child: const Txt(
                    title: "Login",
                    fontContainerWidth: 40,
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
