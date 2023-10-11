import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/user_identification.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text_form_field.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                  const Icon(
                    Icons.work_outline_outlined,
                    color: AppColors.secondaryColorDark,
                    size: Sizes.ICON_SIZE_50 * 3,
                  ),
                  const Txt(
                    title: "Login to your Account",
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: AppColors.black,
                      fontSize: Sizes.TEXT_SIZE_18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Txt(
                    title: "Welcome back, please enter your details",
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: AppColors.black,
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
                              width: 24.0,
                              child: Checkbox(
                                activeColor: AppColors.secondaryColorDark,
                                value: controller.isChecked.value,
                                onChanged: (newValue) {
                                  controller.toggleIsChecked();
                                },
                              ),
                            ),
                          ),
                          const Txt(
                            title: "Remeber me?",
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: AppColors.black,
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
                              color: AppColors.black,
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
                      color: AppColors.secondaryColorDark,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.loading,
                      loadingWidget: controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: AppColors.almondWhite,
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
                      textColor: AppColors.almondWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.blackShade7,
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
                              color: AppColors.blackShade7,
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
                        color: AppColors.greyShade2,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Txt(
                        fontContainerWidth: 160,
                        title: "Don't have an account?",
                        textStyle: TextStyle(
                          fontFamily: "Poppins",
                          color: AppColors.black,
                          fontSize: Sizes.TEXT_SIZE_12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(UserIdentificationScreen());
                        },
                        child: const Txt(
                          title: "Sign Up",
                          fontContainerWidth: 50,
                          textStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: AppColors.secondaryColorDark,
                            fontSize: Sizes.TEXT_SIZE_12,
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
