import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/login_screen.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text_form_field.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.work_outline_outlined,
                  color: AppColors.secondaryColorDark,
                  size: Sizes.ICON_SIZE_50 * 3,
                ),
                const Txt(
                  title: "Create an Account",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: AppColors.black,
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Txt(
                  title: "Signup now to get started with your account",
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
                    onPressed: () {},
                    text: "Sign Up",
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Txt(
                      fontContainerWidth: 170,
                      title: "Already have an account?",
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: AppColors.black,
                        fontSize: Sizes.TEXT_SIZE_12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(LoginScreen());
                      },
                      child: const Txt(
                        title: "Login",
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
    ));
  }
}
