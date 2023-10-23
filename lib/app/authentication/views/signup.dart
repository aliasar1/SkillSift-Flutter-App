import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/views_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  static const String routeName = '/signupScreen';

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
            child: Form(
              key: controller.signupUserFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.APP_ICON,
                    height: Sizes.ICON_SIZE_50 * 1.6,
                    width: Sizes.ICON_SIZE_50 * 3,
                  ),
                  Image.asset(
                    AppAssets.APP_TEXT,
                    height: Sizes.ICON_SIZE_50 * 2,
                    width: Sizes.ICON_SIZE_50 * 4,
                  ),
                  const Txt(
                    title: "Create an Account",
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Txt(
                    title: "Signup now to get started with your account",
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextFormField(
                    controller: controller.nameController,
                    labelText: AppStrings.NAME,
                    autofocus: false,
                    hintText: "",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
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
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
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
                      textInputAction: TextInputAction.done,
                      prefixIconData: Icons.vpn_key_rounded,
                      suffixIconData: controller.isObscure1.value
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      onSuffixTap: controller.toggleVisibility1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
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
                      buttonType: ButtonType.loading,
                      loadingWidget: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: LightTheme.white,
                              ),
                            )
                          : null,
                      onPressed: () {
                        controller.signUpUser(
                            email: controller.emailController.text.trim(),
                            password: controller.passController.text.trim(),
                            confirmPassword:
                                controller.confirmPassController.text.trim(),
                            name: controller.nameController.text.trim());
                      },
                      text: "Sign Up",
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
                      const Txt(
                        fontContainerWidth: 200,
                        title: "Already have an account?",
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: LightTheme.secondaryColor,
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
          ),
        ),
      ),
    ));
  }
}