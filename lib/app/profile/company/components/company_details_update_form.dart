import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skillsift_flutter_app/app/authentication/components/location_picker.dart';
import 'package:skillsift_flutter_app/app/authentication/controllers/auth_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/models/company_model.dart';
import '../controllers/company_profile_controller.dart';

class CompanyDetailsUpdateForm extends StatefulWidget {
  const CompanyDetailsUpdateForm(
      {super.key,
      required this.company,
      required this.companyProfileController,
      required this.authController});

  final Company company;
  final CompanyProfileController companyProfileController;
  final AuthController authController;

  @override
  State<CompanyDetailsUpdateForm> createState() =>
      _CompanyDetailsUpdateFormState();
}

class _CompanyDetailsUpdateFormState extends State<CompanyDetailsUpdateForm> {
  RegExp nameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');

  RegExp phoneRegex = RegExp(r'^\d{11}$');

  final sectorList = [
    'Information Technology',
    'Healthcare Industry',
    'Finance Industry',
    'Manufacturing Industry'
  ];

  final sizeList = ['Small (0-10)', 'Medium (11-50)', 'Large (50+)'];

  var selectedSize = '';

  var selectedIndustry = '';

  @override
  void initState() {
    super.initState();
    widget.companyProfileController.nameController.text =
        widget.company.companyName;
    widget.companyProfileController.companyIndustryController.text =
        widget.company.industryOrSector;
    widget.companyProfileController.companySizeController.text =
        widget.company.companySize;
    widget.companyProfileController.contactNumberController.text =
        widget.company.contactNo;
    widget.companyProfileController.street1Controller.text =
        widget.company.street1;
    widget.companyProfileController.cityController.text = widget.company.city;
    widget.companyProfileController.stateController.text = widget.company.state;
    widget.companyProfileController.countryController.text =
        widget.company.country;
    widget.companyProfileController.postalCodeController.text =
        widget.company.postalCode;
    selectedIndustry = widget.company.industryOrSector;
    selectedSize = widget.company.companySize;
    widget.companyProfileController.countryController.text =
        widget.company.country;
    widget.companyProfileController.stateController.text = widget.company.state;
    widget.companyProfileController.cityController.text = widget.company.city;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: LightTheme.white),
        backgroundColor: LightTheme.primaryColor,
        title: const Txt(
          textAlign: TextAlign.start,
          title: "Update Company Details",
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.white,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Form(
          key: widget.companyProfileController.updateInfoKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: widget.companyProfileController.nameController,
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
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                icon: Icons.factory,
                selectedValue: selectedIndustry,
                items: sectorList,
                title: 'Company Industry',
                onChanged: (value) {
                  setState(() {
                    selectedIndustry = value!;
                    widget.companyProfileController.companyIndustryController
                        .text = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown(
                icon: Icons.groups,
                selectedValue: selectedSize,
                items: sizeList,
                title: 'Company Size',
                onChanged: (value) {
                  setState(() {
                    selectedSize = value!;
                    widget.companyProfileController.companySizeController.text =
                        value;
                  });
                },
              ),
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
                initialCountryCode: 'PK',
                autofocus: false,
                controller:
                    widget.companyProfileController.contactNumberController,
                cursorColor: LightTheme.primaryColorLightShade,
                onSaved: (phone) {
                  widget.companyProfileController.contactNumberController.text =
                      phone!.completeNumber;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: widget.companyProfileController.street1Controller,
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
                controller:
                    widget.companyProfileController.postalCodeController,
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
                currentCity: widget.company.city,
                currentState: widget.company.state,
                currentCountry: widget.company.country,
                onCountryChanged: (country) {
                  widget.companyProfileController.countryController.text =
                      country;
                },
                onStateChanged: (state) {
                  widget.companyProfileController.stateController.text =
                      state ?? "";
                },
                onCityChanged: (city) {
                  widget.companyProfileController.cityController.text =
                      city ?? "";
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
                    border:
                        Border.all(color: LightTheme.primaryColor, width: 1),
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
                      const Icon(Icons.check_box, color: Colors.green),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                color: LightTheme.primaryColor,
                textColor: LightTheme.white,
                text: "Update",
                buttonType: ButtonType.loading,
                isLoading: widget.companyProfileController.isLoading.value,
                loadingWidget: widget.companyProfileController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: LightTheme.white,
                        ),
                      )
                    : null,
                hasInfiniteWidth: true,
                onPressed: () {
                  widget.companyProfileController.updateCompanyDetails();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
