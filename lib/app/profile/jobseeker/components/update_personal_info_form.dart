import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skillsift_flutter_app/app/profile/jobseeker/controllers/profile_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';

class UpdatePersonalInfoForm extends StatelessWidget {
  const UpdatePersonalInfoForm({super.key, required this.profileController});

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: LightTheme.white),
        backgroundColor: LightTheme.primaryColor,
        title: const Txt(
          textAlign: TextAlign.start,
          title: "Update Personal Info",
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
          key: profileController.editInfoFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: profileController.nameController,
                labelText: 'Name',
                prefixIconData: Icons.person,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: Sizes.SIZE_12),
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
                controller: profileController.phoneController,
                cursorColor: LightTheme.primaryColorLightShade,
                onSaved: (phone) {
                  profileController.phoneController.text = phone!.number;
                },
              ),
              const SizedBox(height: Sizes.HEIGHT_10),
              CustomButton(
                buttonType: ButtonType.loading,
                isLoading: profileController.isLoading.value,
                color: LightTheme.primaryColor,
                loadingWidget: profileController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: LightTheme.white,
                        ),
                      )
                    : null,
                onPressed: () {
                  profileController.updateUserProfile(
                    profileController.nameController.text.trim(),
                    profileController.phoneController.text.trim(),
                  );
                  Navigator.of(context).pop();
                },
                text: "Edit",
                hasInfiniteWidth: true,
                textColor: LightTheme.whiteShade2,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
