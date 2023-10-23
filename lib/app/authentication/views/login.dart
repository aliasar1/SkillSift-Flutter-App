import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/user_identification.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/loginScreen';

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
                key: controller.loginFormKey,
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
                      title: "Login to your Account",
                      fontContainerWidth: double.infinity,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.secondaryColor,
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Txt(
                      title: "Welcome back, please enter your details",
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
                            const Txt(
                              title: "Remember me?",
                              textStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: LightTheme.black,
                                fontSize: Sizes.TEXT_SIZE_12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
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
                        ),
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
                        loadingWidget: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: LightTheme.white,
                                ),
                              )
                            : null,
                        onPressed: () {
                          controller.loginUser(
                              email: controller.emailController.text.trim(),
                              password: controller.passController.text.trim());
                        },
                        text: "Login",
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Txt(
                          fontContainerWidth: 180,
                          title: "Don't have an account?",
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: LightTheme.secondaryColor,
                            fontSize: Sizes.TEXT_SIZE_14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
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
            ),
          ),
        ),
      ),
    );
  }
}


/*

IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: LightTheme.blackShade4,
                            ),
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        const Text(
                          "Or Continue With",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontSize: Sizes.TEXT_SIZE_12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: LightTheme.blackShade4,
                            ),
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: LightTheme.blackShade4,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Image.asset('assets/images/gmail.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

 */