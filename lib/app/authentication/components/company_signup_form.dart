import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/recruiter_model.dart';
import '../../recruiter/views/recruiter_dashboard.dart';
import '../controllers/auth_controller.dart';
import '../controllers/stepper_controller.dart';
import 'location_picker.dart';

class CompanySignupForm extends StatefulWidget {
  const CompanySignupForm({
    super.key,
    required this.authController,
    required this.stepperController,
    required this.recruiter,
  });

  final AuthController authController;
  final StepperController stepperController;
  final Recruiter recruiter;

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

  String? prefix;

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
            const Txt(
              textAlign: TextAlign.start,
              fontContainerWidth: double.infinity,
              fontMaxLines: 10,
              title:
                  "I agree to all terms and conditions, which include but are not limited to: providing accurate company information for registration verification, complying with app usage policies, and acknowledging that incomplete or inaccurate information may result in restricted access to app features.",
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontSize: Sizes.TEXT_SIZE_12,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 15,
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
                  textAlign: TextAlign.start,
                  title: "  Yes, I agree.",
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
          IntlPhoneField(
            showDropdownIcon: true,
            pickerDialogStyle: PickerDialogStyle(
              searchFieldPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              backgroundColor: LightTheme.whiteShade2,
              searchFieldInputDecoration: const InputDecoration(
                labelText: 'Country Code',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: LightTheme.black,
                  fontSize: Sizes.SIZE_16,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: LightTheme.primaryColor,
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.completeNumber.isEmpty) {
                return "Contact number cannot be empty.";
              }
              return null;
            },
            dropdownTextStyle: const TextStyle(
              fontFamily: 'Poppins',
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0.0),
              labelText: 'Phone Number',
              labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                color: LightTheme.black,
                fontSize: Sizes.SIZE_16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: null,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: LightTheme.primaryColorLightShade, width: 1),
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
              ),
              alignLabelWithHint: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: LightTheme.primaryColorLightShade,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
              ),
              floatingLabelStyle: const TextStyle(
                color: LightTheme.primaryColor,
                fontFamily: 'Poppins',
                fontSize: Sizes.SIZE_20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: LightTheme.primaryColorLightShade, width: 1),
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
              ),
              focusColor: LightTheme.primaryColor,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
                borderSide: const BorderSide(color: Colors.red, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
                borderSide: const BorderSide(color: Colors.red),
              ),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'Poppins',
                fontSize: Sizes.SIZE_12,
              ),
            ),
            initialCountryCode: "PK",
            autofocus: false,
            controller: widget.authController.contactNumberController,
            cursorColor: LightTheme.primaryColorLightShade,
            onSaved: (phone) {
              widget.authController.fullContactNumberController.text =
                  phone!.completeNumber;
              widget.authController.contactNumberController.text = phone.number;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.emailController,
            labelText: "Company Email Address",
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
          CSCPicker(
            layout: Layout.vertical,
            onCountryChanged: (country) {
              widget.authController.countryController.text = country;
            },
            onStateChanged: (state) {
              widget.authController.stateController.text = state ?? "";
            },
            onCityChanged: (city) {
              widget.authController.cityController.text = city ?? "";
            },
            countryDropdownLabel: "Country",
            stateDropdownLabel: "State",
            cityDropdownLabel: "City",
            dropdownDialogRadius: Sizes.RADIUS_4,
            dropdownDecoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: LightTheme.primaryColorLightShade,
              ),
              borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
            ),
            disabledDropdownDecoration: BoxDecoration(
              color: LightTheme.grey,
              border: Border.all(
                width: 1,
                color: LightTheme.primaryColorLightShade,
              ),
              borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
            ),
            selectedItemStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: Sizes.SIZE_16,
            ),
            dropdownHeadingStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: Sizes.SIZE_16,
            ),
            dropdownItemStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: Sizes.SIZE_16,
            ),
            searchBarRadius: Sizes.RADIUS_4,
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
                  Txt(
                    fontContainerWidth: 120,
                    title: widget.authController.location.isNotEmpty
                        ? 'Location Picked'
                        : 'Pick Location',
                    textStyle: const TextStyle(fontFamily: 'Poppins'),
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
      title: const Text("Company Basic Information"),
      content: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: widget.authController.nameController,
            labelText: "Company Name",
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
    final authController = widget.authController;
    String companyName = authController.nameController.text.trim();
    String industryOrSector =
        authController.companyIndustryController.text.trim();
    String companySize = authController.companySizeController.text.trim();
    String contactNo = authController.contactNumberController.text.trim();
    String contactEmail = authController.emailController.text.trim();
    String street1 = authController.street1Controller.text.trim();
    String city = authController.cityController.text.trim();
    String country = authController.countryController.text.trim();
    String postalCode = authController.postalCodeController.text.trim();
    String state = authController.stateController.text.trim();
    bool termsAndConditionsAccepted = authController.isChecked.value;

    // Checking if Country, State, and City are filled
    bool isCSCPicked = authController.checkIfCSCIsFilled();

    LoadingDialog.showLoadingDialog(context, 'Processing request...');

    try {
      // Call registerCompany method in the controller
      bool success = await authController.registerCompany(
        companyName: companyName,
        industryOrSector: industryOrSector,
        companySize: companySize,
        contactNo: contactNo,
        contactEmail: contactEmail,
        street1: street1,
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
        termsAndConditionsAccepted: termsAndConditionsAccepted,
      );
      print(success);

      LoadingDialog.hideLoadingDialog(context);
      Get.closeAllSnackbars();

      if (!success) {
        if (authController.contactNumberController.text.isEmpty) {
          Get.snackbar(
              'Contact Number Empty', 'Please provide company contact number.');
        } else if (!isCSCPicked) {
          Get.snackbar('Fields Empty', 'Please pick Country, State, and City.');
        } else if (!authController.isLocationPicked.value) {
          Get.snackbar('Location Empty', 'Please pick a location to register.');
        } else if (!authController.isChecked.value) {
          Get.snackbar('Confirm Terms and Conditions',
              'Please confirm terms and conditions to create an account.');
        }
      } else {
        // On successful registration
        authController.clearFields();
        widget.recruiter.companyId = widget.authController.companyId.toString();
        Get.offAll(RecruiterDashboard(recruiter: widget.recruiter));
        Get.snackbar(
          'Account created successfully!',
          'Please wait unitl 1-2 days for your account to be activated.',
        );
      }
    } catch (e) {
      LoadingDialog.hideLoadingDialog(context);
      Get.snackbar(
        'Error',
        'An error occurred: $e',
      );
    }
  }
}
