import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/theme/light_theme.dart';
import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/autocomplete_prediction.dart';
import '../../../core/models/place_autocomplete_response.dart';
import '../../../core/services/place_api.dart';
import '../controllers/auth_controller.dart';
import '../controllers/stepper_controller..dart';

class CompanySignupScreen extends StatefulWidget {
  const CompanySignupScreen({super.key});

  @override
  State<CompanySignupScreen> createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final authController = Get.put(AuthController());
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
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    AppAssets.APP_ICON,
                    height: Sizes.ICON_SIZE_50 * 1.6,
                    width: Sizes.ICON_SIZE_50 * 3,
                  ),
                  Image.asset(
                    AppAssets.APP_TEXT,
                    height: Sizes.ICON_SIZE_50 * 1.7,
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
                  Obx(
                    () => Form(
                      key: authController.signupCompanyFormKey,
                      child: Stepper(
                        controller: ScrollController(),
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
                            String companyName =
                                authController.nameController.text.trim();
                            String industryOrSector = authController
                                .companyIndustryController.text
                                .trim();
                            String companySize = authController
                                .companySizeController.text
                                .trim();
                            String contactNo = authController
                                .contactNumberController.text
                                .trim();
                            String contactEmail =
                                authController.emailController.text.trim();
                            String password =
                                authController.passController.text.trim();
                            String street1 =
                                authController.street1Controller.text.trim();
                            String street2 =
                                authController.street2Controller.text.trim();
                            String city =
                                authController.cityController.text.trim();
                            String country =
                                authController.countryController.text.trim();
                            String postalCode =
                                authController.postalCodeController.text.trim();
                            bool termsAndConditionsAccepted =
                                authController.isChecked.value;

                            authController.registerCompany(
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
                                        stepperController
                                            .incrementCurrentStep();
                                      } else {
                                        String companyName = authController
                                            .nameController.text
                                            .trim();
                                        String industryOrSector = authController
                                            .companyIndustryController.text
                                            .trim();
                                        String companySize = authController
                                            .companySizeController.text
                                            .trim();
                                        String contactNo = authController
                                            .contactNumberController.text
                                            .trim();
                                        String contactEmail = authController
                                            .emailController.text
                                            .trim();
                                        String password = authController
                                            .passController.text
                                            .trim();
                                        String street1 = authController
                                            .street1Controller.text
                                            .trim();
                                        String street2 = authController
                                            .street2Controller.text
                                            .trim();
                                        String city = authController
                                            .cityController.text
                                            .trim();
                                        String country = authController
                                            .countryController.text
                                            .trim();
                                        String postalCode = authController
                                            .postalCodeController.text
                                            .trim();
                                        bool termsAndConditionsAccepted =
                                            authController.isChecked.value;

                                        authController.registerCompany(
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        LightTheme.primaryColor,
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                        LightTheme.white,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    child:
                                        Text(isLastStep ? 'Confirm' : 'Next'),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                if (stepperController.getCurrentStep != 0)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: controller.onStepCancel,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                LightTheme.greyShade1),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                LightTheme.primaryColor),
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

  RegExp nameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
  RegExp phoneRegex = RegExp(r'^\d{11}$');

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
                controller: authController.nameController,
                labelText: AppStrings.NAME,
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.name,
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
                primaryColor: LightTheme.white,
                secondaryColor: LightTheme.primaryColorLightShade,
                textColor: LightTheme.black,
                suffixIcon: Icons.factory,
                onChange: (value) {
                  setState(() {
                    selectedIndustry = value!;
                  });
                  authController.companyIndustryController.text = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                items: const ['Small (0-10)', 'Medium (11-50)', 'Large (50+)'],
                selectedText: selectedText,
                primaryColor: LightTheme.white,
                secondaryColor: LightTheme.primaryColorLightShade,
                textColor: LightTheme.black,
                suffixIcon: Icons.groups,
                onChange: (value) {
                  setState(() {
                    selectedText = value!;
                  });
                  authController.companySizeController.text = value!;
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
                controller: authController.contactNumberController,
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
                controller: authController.emailController,
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
                height: 10,
              ),
              CustomTextFormField(
                controller: authController.street1Controller,
                labelText: "Street 1",
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.map,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Street 1 cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: authController.street2Controller,
                labelText: 'Street 2',
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIconData: Icons.map,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: authController.postalCodeController,
                labelText: 'Postal Code',
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
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
                controller: authController.cityController,
                labelText: 'City',
                autofocus: false,
                hintText: "",
                keyboardType: TextInputType.text,
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
                controller: authController.countryController,
                labelText: 'Country',
                autofocus: false,
                keyboardType: TextInputType.text,
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
              // const Text('Or'),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextButton.icon(
              //     onPressed: () {
              //       LocationPickerDialog(
              //           placeController: placeController,
              //           placeAutocomplete: placeAutocomplete);
              //     },
              //     icon: const Icon(Icons.ac_unit),
              //     label: const Text('Search Location')),
              // const SizedBox(
              //   height: 10,
              // ),
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
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => CustomTextFormField(
                    controller: authController.passController,
                    labelText: AppStrings.PASSWORD,
                    autofocus: false,
                    hintText: AppStrings.PASSWORD,
                    obscureText: authController.isObscure.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIconData: Icons.vpn_key_rounded,
                    suffixIconData: authController.isObscure.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    onSuffixTap: authController.toggleVisibility,
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
                    controller: authController.confirmPassController,
                    labelText: "Confirm Password",
                    autofocus: false,
                    hintText: AppStrings.PASSWORD,
                    obscureText: authController.isObscure1.value,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    prefixIconData: Icons.vpn_key_rounded,
                    suffixIconData: authController.isObscure1.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    onSuffixTap: authController.toggleVisibility1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value != authController.passController.text) {
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
                          value: authController.isChecked.value,
                          onChanged: (newValue) {
                            authController.toggleIsChecked();
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
            )),
      ];

  List<AutocompletePrediction> places = [];
  final placeController = TextEditingController();

  void placeAutocomplete(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {"input": query, "key": 'AIzaSyAC41qD4CKnJGwlWAXs46TPoBvxwLwc5e4'});
    String? response = await PlaceApi.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          places = result.predictions!;
        });
      }
    }
  }
}
