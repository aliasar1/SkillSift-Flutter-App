import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/controllers/stepper_controller.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text_form_field.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_dropdown.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class CompanySignupScreen extends StatefulWidget {
  CompanySignupScreen({super.key});

  @override
  State<CompanySignupScreen> createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final atuhController = Get.put(AuthController());

  final stepperController = Get.put(StepperController());
  var selectedText = 'Company Size';
  var selectedIndustry = 'Industry of Company';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                                onPressed: () {
                                  if (!isLastStep) {
                                    stepperController.incrementCurrentStep();
                                  } else {
                                    String companyName = atuhController
                                        .nameController.text
                                        .trim();
                                    String industryOrSector = atuhController
                                        .companyIndustryController.text
                                        .trim();
                                    String companySize = atuhController
                                        .companySizeController.text
                                        .trim();
                                    String contactNo = atuhController
                                        .contactNumberController.text
                                        .trim();
                                    String contactEmail = atuhController
                                        .emailController.text
                                        .trim();
                                    String password = atuhController
                                        .passController.text
                                        .trim();
                                    String street1 = atuhController
                                        .street1Controller.text
                                        .trim();
                                    String street2 = atuhController
                                        .street2Controller.text
                                        .trim();
                                    String city = atuhController
                                        .cityController.text
                                        .trim();
                                    String country = atuhController
                                        .countryController.text
                                        .trim();
                                    String postalCode = atuhController
                                        .postalCodeController.text
                                        .trim();
                                    bool termsAndConditionsAccepted =
                                        atuhController.isChecked.value;

                                    atuhController.registerCompany(
                                      companyName: companyName,
                                      industryOrSector: industryOrSector,
                                      companySize: companySize,
                                      location: "",
                                      contactNo: contactNo,
                                      contactEmail: contactEmail,
                                      password: password,
                                      street1: street1,
                                      street2: street2,
                                      city: city,
                                      country: country,
                                      postalCode: postalCode,
                                      termsAndConditionsAccepted:
                                          termsAndConditionsAccepted,
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.secondaryColorDark),
                                  foregroundColor: MaterialStateProperty.all(
                                      AppColors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
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
                                            BorderRadius.circular(4.0),
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
          title: const Text("Basic Information"),
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.nameController,
                labelText: AppStrings.NAME,
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.domain,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                items: const [
                  'Information Technology',
                  'Healthcare Industry',
                  'Finance Industry',
                  'Manufacturing Industry'
                ],
                selectedText: selectedIndustry,
                primaryColor: AppColors.white,
                secondaryColor: AppColors.primaryLightColor,
                textColor: AppColors.black,
                suffixIcon: Icons.factory,
                onChange: (value) {
                  setState(() {
                    selectedIndustry = value!;
                  });
                  atuhController.companyIndustryController.text = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                items: const ['Small (0-10)', 'Medium (11-50)', 'Large (50+)'],
                selectedText: selectedText,
                primaryColor: AppColors.white,
                secondaryColor: AppColors.primaryLightColor,
                textColor: AppColors.black,
                suffixIcon: Icons.groups,
                onChange: (value) {
                  setState(() {
                    selectedText = value!;
                  });
                  atuhController.companySizeController.text = value!;
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
          title: const Text("Contact Information"),
          content: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.contactNumberController,
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
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.emailController,
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
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.street1Controller,
                labelText: "Street 1",
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.map,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.street2Controller,
                labelText: 'Street 2',
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.map,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.postalCodeController,
                labelText: 'Postal Code',
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.code,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.cityController,
                labelText: 'City',
                autofocus: false,
                hintText: "abc@gmail.com",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.location_city,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: atuhController.countryController,
                labelText: 'Country',
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.location_on,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
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
                Obx(
                  () => CustomTextFormField(
                    controller: atuhController.passController,
                    labelText: AppStrings.PASSWORD,
                    autofocus: false,
                    hintText: AppStrings.PASSWORD,
                    obscureText: atuhController.isObscure.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIconData: Icons.vpn_key_rounded,
                    suffixIconData: atuhController.isObscure.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    onSuffixTap: atuhController.toggleVisibility,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: atuhController.confirmPassController,
                    labelText: "Confirm Password",
                    autofocus: false,
                    hintText: AppStrings.PASSWORD,
                    obscureText: atuhController.isObscure1.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIconData: Icons.vpn_key_rounded,
                    suffixIconData: atuhController.isObscure1.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    onSuffixTap: atuhController.toggleVisibility1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          activeColor: AppColors.secondaryColorDark,
                          value: atuhController.isChecked.value,
                          onChanged: (newValue) {
                            atuhController.toggleIsChecked();
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
