import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/controllers/stepper_controller.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text_form_field.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class CompanySignupScreen extends StatelessWidget {
  CompanySignupScreen({super.key});

  final controller = Get.put(AuthController());
  final stepperController = Get.put(StepperController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsetsDirectional.symmetric(
                vertical: 10, horizontal: 10),
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
                Obx(
                  () => Stepper(
                    type: StepperType.vertical,
                    steps: getSteps(),
                    currentStep: stepperController.getCurrentStep,
                    onStepTapped: (step) {
                      stepperController.setCurrentStep(step);
                    },
                    onStepContinue: () {
                      final isLastStep = stepperController.getCurrentStep ==
                          getSteps().length - 1;
                      if (isLastStep) {
                        // print("Done");
                      } else {
                        stepperController.incrementCurrentStep();
                      }
                    },
                    onStepCancel: () {
                      stepperController.getCurrentStep == 0
                          ? null
                          : stepperController.decreamentCurrentStep();
                    },
                    controlsBuilder: (context, controller) {
                      final isLastStep = stepperController.getCurrentStep ==
                          getSteps().length - 1;
                      return Container(
                        margin: const EdgeInsetsDirectional.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controller.onStepContinue,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.secondaryColorDark),
                                  foregroundColor: MaterialStateProperty.all(
                                      AppColors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                child: Text(isLastStep ? 'Confirm' : 'Next'),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            if (stepperController.getCurrentStep != 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controller.onStepCancel,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.greyShade1),
                                    foregroundColor: MaterialStateProperty.all(
                                        AppColors.secondaryColorDark),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Back'),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  List<Step> getSteps() => [
        Step(
          isActive: stepperController.getCurrentStep >= 0,
          state: stepperController.getCurrentStep > 0
              ? StepState.complete
              : StepState.indexed,
          title: const Text("Details"),
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: controller.nameController,
                labelText: AppStrings.NAME,
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.work,
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
                controller: controller.companySizeController,
                labelText: "Company Size",
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.abc,
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
            ],
          ),
        ),
        Step(
          isActive: stepperController.getCurrentStep >= 1,
          state: stepperController.getCurrentStep > 1
              ? StepState.complete
              : StepState.indexed,
          title: const Text("Address"),
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: controller.contactNumberController,
                labelText: "Contact Number",
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.phone,
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
            ],
          ),
        ),
        Step(
            isActive: stepperController.getCurrentStep >= 2,
            state: stepperController.getCurrentStep > 2
                ? StepState.complete
                : StepState.indexed,
            title: const Text("Confirmation"),
            content: Column(
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
                      fontContainerWidth: 250,
                      title: "I agree to all terms and condition.?",
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: AppColors.black,
                        fontSize: Sizes.TEXT_SIZE_12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ];
}
