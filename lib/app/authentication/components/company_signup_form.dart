import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/login.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/auth_controller.dart';
import '../controllers/stepper_controller.dart';
import 'location_picker.dart';

class CompanySignupForm extends StatefulWidget {
  const CompanySignupForm({
    super.key,
    required this.authController,
    required this.stepperController,
  });

  final AuthController authController;
  final StepperController stepperController;

  @override
  State<CompanySignupForm> createState() => _CompanySignupFormState();
}

class _CompanySignupFormState extends State<CompanySignupForm> {
  RegExp nameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');

  RegExp phoneRegex = RegExp(r'^\d{11}$');

  final sectorList = [
    'Information Technology',
    'Healthcare Industry',
    'Finance Industry',
    'Manufacturing Industry'
  ];

  final sizeList = ['Small (0-10)', 'Medium (11-50)', 'Large (50+)'];

  var selectedSize = 'Small (0-10)';

  var selectedIndustry = 'Information Technology';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: widget.authController.signupCompanyFormKey,
        child: Stepper(
          controller: ScrollController(),
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: widget.stepperController.getCurrentStep,
          onStepTapped: (step) {
            widget.stepperController.setCurrentStep(step);
          },
          onStepContinue: () {
            final isLastStep = widget.stepperController.getCurrentStep ==
                getSteps().length - 1;
            if (isLastStep) {
              registerCompanyFromWidgets(context);
            } else {
              widget.stepperController.incrementCurrentStep();
            }
          },
          onStepCancel: () {
            widget.stepperController.getCurrentStep == 0
                ? null
                : widget.stepperController.decreamentCurrentStep();
          },
          controlsBuilder: (context, controller) {
            final isLastStep = widget.stepperController.getCurrentStep ==
                getSteps().length - 1;
            return Container(
              margin: const EdgeInsetsDirectional.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!isLastStep) {
                          widget.stepperController.incrementCurrentStep();
                        } else {
                          registerCompanyFromWidgets(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          LightTheme.primaryColor,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          LightTheme.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      child: Text(isLastStep ? 'Confirm' : 'Next'),
                    ),
                  ),
                  if (widget.stepperController.getCurrentStep != 0)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12),
                        child: ElevatedButton(
                          onPressed: controller.onStepCancel,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                LightTheme.greyShade1),
                            foregroundColor: MaterialStateProperty.all(
                                LightTheme.primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        basicInformationStep(),
        contactInformationStep(),
        confirmationStep(),
      ];

  Step confirmationStep() {
    return Step(
        isActive: widget.stepperController.getCurrentStep >= 2,
        state: widget.stepperController.getCurrentStep > 2
            ? StepState.complete
            : StepState.indexed,
        title: const Text("Confirmation"),
        content: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => CustomTextFormField(
                controller: widget.authController.passController,
                labelText: AppStrings.PASSWORD,
                autofocus: false,
                hintText: AppStrings.PASSWORD,
                obscureText: widget.authController.isObscure.value,
                keyboardType: TextInputType.visiblePassword,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
                prefixIconData: Icons.vpn_key_rounded,
                suffixIconData: widget.authController.isObscure.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: widget.authController.toggleVisibility,
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
              height: 10,
            ),
            Obx(
              () => CustomTextFormField(
                controller: widget.authController.confirmPassController,
                labelText: "Confirm Password",
                autofocus: false,
                hintText: AppStrings.PASSWORD,
                obscureText: widget.authController.isObscure1.value,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                prefixIconData: Icons.vpn_key_rounded,
                suffixIconData: widget.authController.isObscure1.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: widget.authController.toggleVisibility1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value !=
                      widget.authController.passController.text) {
                    return "Passwords do not match";
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
                      activeColor: LightTheme.primaryColor,
                      value: widget.authController.isChecked.value,
                      onChanged: (newValue) {
                        widget.authController.toggleIsChecked();
                      },
                    ),
                  ),
                ),
                const Txt(
                  fontContainerWidth: 250,
                  title: "I agree to all terms and condition.?",
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.black,
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
        ));
  }

  Step contactInformationStep() {
    return Step(
      isActive: widget.stepperController.getCurrentStep >= 1,
      state: widget.stepperController.getCurrentStep > 1
          ? StepState.complete
          : StepState.indexed,
      title: const Text("Contact Information"),
      content: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.contactNumberController,
            labelText: "Contact Number",
            autofocus: false,
            hintText: "",
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return "Contact number cannot be empty";
              } else if (!phoneRegex.hasMatch(value)) {
                return "Invalid phone number. Please enter 11 digits.";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.emailController,
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
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.street1Controller,
            labelText: "Street",
            autofocus: false,
            hintText: "",
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.map,
            validator: (value) {
              if (value!.isEmpty) {
                return "Street cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.postalCodeController,
            labelText: 'Postal Code',
            autofocus: false,
            hintText: "",
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.code,
            validator: (value) {
              if (value!.isEmpty) {
                return "Postal Code cannot be empty";
              }
              if (!RegExp(r'^\d+$').hasMatch(value)) {
                return "Postal Code can only have numbers";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.cityController,
            labelText: 'City',
            autofocus: false,
            hintText: "",
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.location_city,
            validator: (value) {
              if (value!.isEmpty) {
                return "City cannot be empty";
              } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                return "City must contain only alphabetic characters.";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.countryController,
            labelText: 'Country',
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.location_on,
            validator: (value) {
              if (value!.isEmpty) {
                return "Country cannot be empty";
              } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                return "Country must contain only alphabetic characters.";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.to(SearchLocationScreen(
                authController: widget.authController,
              ));
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: LightTheme.primaryColor, width: 1),
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.map, color: LightTheme.primaryColor),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.authController.location.isNotEmpty
                        ? 'Location Picked'
                        : 'Pick Location',
                    style: const TextStyle(fontFamily: 'Poppins'),
                  ),
                  const Spacer(),
                  Obx(() => widget.authController.isLocationPicked.value
                      ? const Icon(Icons.check_box, color: Colors.green)
                      : const Icon(Icons.dangerous, color: Colors.red)),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Step basicInformationStep() {
    return Step(
      isActive: widget.stepperController.getCurrentStep >= 0,
      state: widget.stepperController.getCurrentStep > 0
          ? StepState.complete
          : StepState.indexed,
      title: const Text("Basic Information"),
      content: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.nameController,
            labelText: AppStrings.NAME,
            autofocus: false,
            hintText: "",
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            prefixIconData: Icons.domain,
            validator: (value) {
              if (value!.isEmpty) {
                return "Name cannot be empty";
              } else if (!nameRegex.hasMatch(value)) {
                return "Invalid characters. Only alphanumeric characters and spaces are allowed.";
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomDropdown(
            icon: Icons.factory,
            selectedValue: selectedIndustry,
            items: sectorList,
            title: 'Company Industry',
            onChanged: (value) {
              setState(() {
                selectedIndustry = value!;
                widget.authController.companyIndustryController.text = value;
              });
            },
          ),
          const SizedBox(height: 15),
          CustomDropdown(
            icon: Icons.groups,
            selectedValue: selectedSize,
            items: sizeList,
            title: 'Company Size',
            onChanged: (value) {
              setState(() {
                selectedSize = value!;
                widget.authController.companySizeController.text = value;
              });
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> registerCompanyFromWidgets(BuildContext context) async {
    String companyName = widget.authController.nameController.text.trim();
    String industryOrSector =
        widget.authController.companyIndustryController.text.trim();
    String companySize =
        widget.authController.companySizeController.text.trim();
    String contactNo =
        widget.authController.contactNumberController.text.trim();
    String contactEmail = widget.authController.emailController.text.trim();
    String password = widget.authController.passController.text.trim();
    String street1 = widget.authController.street1Controller.text.trim();
    String city = widget.authController.cityController.text.trim();
    String country = widget.authController.countryController.text.trim();
    String postalCode = widget.authController.postalCodeController.text.trim();
    bool termsAndConditionsAccepted = widget.authController.isChecked.value;
    LoadingDialog.showLoadingDialog(context, 'Processing request...');
    widget.authController
        .registerCompany(
          companyName: companyName,
          industryOrSector: industryOrSector,
          companySize: companySize,
          contactNo: contactNo,
          contactEmail: contactEmail,
          password: password,
          street1: street1,
          city: city,
          country: country,
          postalCode: postalCode,
          termsAndConditionsAccepted: termsAndConditionsAccepted,
        )
        .then((value) => {
              LoadingDialog.hideLoadingDialog(context),
              if (!value)
                {
                  if (widget.authController.isLocationPicked.isFalse)
                    {
                      Get.snackbar('Location Empty',
                          'Please pick location to register.'),
                    }
                  else if (widget.authController.isChecked.isFalse)
                    {
                      Get.snackbar('Confirm Terms and Conditions',
                          'Please confitms terms and condition to create account.'),
                    }
                }
              else
                {
                  Get.offAll(LoginScreen()),
                  Get.snackbar(
                    'Account created successfully!',
                    'Please verify account to proceed.',
                  ),
                }
            });
  }
}
