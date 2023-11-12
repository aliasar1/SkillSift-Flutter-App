import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/user_identification.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';
import 'package:skillsift_flutter_app/core/exports/views_exports.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../dashboard/views/company_dashboard.dart';
import '../../dashboard/views/jobs_dashboard.dart';
import '../controllers/auth_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/loginScreen';

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(IntroScreen());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_8),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.question_mark,
                      color: LightTheme.secondaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
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
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Form(
                                      key: controller.resetPasswordFormKey,
                                      child: Container(
                                        width: double.infinity,
                                        height: Get.height * 0.45,
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Column(
                                              children: [
                                                Txt(
                                                  textAlign: TextAlign.start,
                                                  fontContainerWidth:
                                                      double.infinity,
                                                  title: 'Forgot Password',
                                                  textStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: LightTheme.black,
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Txt(
                                                  textAlign: TextAlign.start,
                                                  fontContainerWidth:
                                                      double.infinity,
                                                  title:
                                                      'Enter your email for the verification process, we will send you a reset password email to the provided email address.',
                                                  textStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: LightTheme.black,
                                                    fontSize:
                                                        Sizes.TEXT_SIZE_14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CustomTextFormField(
                                              controller: controller
                                                  .resetEmailController,
                                              labelText:
                                                  AppStrings.EMAIL_ADDRESS,
                                              autofocus: false,
                                              hintText: "abc@gmail.com",
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.done,
                                              prefixIconData: Icons.email,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Email cannot be empty";
                                                } else if (!GetUtils.isEmail(
                                                    value)) {
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
                                                isLoading:
                                                    controller.isLoading.value,
                                                loadingWidget: controller
                                                        .isLoading.value
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                          backgroundColor:
                                                              LightTheme
                                                                  .primaryColor,
                                                        ),
                                                      )
                                                    : null,
                                                onPressed: () {
                                                  controller.resetPassword(
                                                      controller
                                                          .resetEmailController
                                                          .text
                                                          .trim());
                                                },
                                                text: "Send Email",
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 45,
                                                        minHeight: 45),
                                                buttonPadding:
                                                    const EdgeInsets.all(0),
                                                customTextStyle:
                                                    const TextStyle(
                                                        fontSize:
                                                            Sizes.TEXT_SIZE_14,
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                textColor: LightTheme.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).whenComplete(() =>
                                  controller.resetEmailController.clear());
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
                            bool isValid = await controller.loginUser(
                                email: controller.emailController.text.trim(),
                                password:
                                    controller.passController.text.trim());
                            if (!isValid) {
                              verifyDialog(controller);
                            } else {
                              final type = controller.getUserType();
                              if (type == 'company') {
                                Get.offAll(const CompanyDashboard());
                              } else if (type == 'jobseeker') {
                                Get.offAll(DashboardScreen());
                              } else {}
                            }
                          },
                          text: "Login",
                          constraints: const BoxConstraints(
                              maxHeight: 45, minHeight: 45),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> verifyDialog(AuthController controller) {
    return Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: LightTheme.white,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "Verify your email",
            fontContainerWidth: 100,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Txt(
            textAlign: TextAlign.start,
            title: "An email is sent to you, please verify your account.",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.black,
              fontSize: Sizes.TEXT_SIZE_14,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await firebaseAuth.currentUser!.sendEmailVerification();
                  Get.back();
                } catch (e) {
                  Get.snackbar(
                    'Error',
                    'Failed to send email verification: $e',
                  );
                }
              },
              child: const Txt(
                title: "Back",
                fontContainerWidth: 100,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.primaryColor,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(LightTheme.primaryColor)),
              onPressed: () {
                Get.back();
              },
              child: const Txt(
                title: "Resend Email",
                fontContainerWidth: 100,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.white,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
