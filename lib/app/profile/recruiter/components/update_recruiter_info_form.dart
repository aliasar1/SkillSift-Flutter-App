import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skillsift_flutter_app/core/exports/constants_exports.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';

import '../../../../core/exports/widgets_export.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../controller/recruiter_profile_controller.dart';

class UpdateRecruiterInfoForm extends StatefulWidget {
  UpdateRecruiterInfoForm({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<UpdateRecruiterInfoForm> createState() =>
      _UpdateRecruiterInfoFormState();
}

class _UpdateRecruiterInfoFormState extends State<UpdateRecruiterInfoForm> {
  final authController = Get.put(AuthController());

  final recruiterProfileController = Get.put(RecruiterProfileController());

  @override
  void initState() {
    super.initState();
    recruiterProfileController.nameController.text = widget.recruiter.fullName;
    recruiterProfileController.phoneController.text = widget.recruiter.phone;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: LightTheme.white),
          backgroundColor: LightTheme.primaryColor,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "Update Details",
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
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: recruiterProfileController.nameController,
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
                      searchFieldPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
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
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
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
                    initialValue:
                        recruiterProfileController.phoneController.text,
                    controller: recruiterProfileController.phoneController,
                    cursorColor: LightTheme.primaryColorLightShade,
                    onSaved: (phone) {
                      recruiterProfileController.phoneController.text =
                          phone!.number;
                    },
                  ),
                  const SizedBox(height: Sizes.HEIGHT_14),
                  Obx(
                    () => CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      isLoading: recruiterProfileController.isLoading2.value,
                      buttonType: ButtonType.loading,
                      loadingWidget: recruiterProfileController.isLoading2.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: LightTheme.primaryColor,
                              ),
                            )
                          : null,
                      onPressed: () {
                        recruiterProfileController.updateInfo(
                            recruiterProfileController.nameController.text
                                .trim(),
                            recruiterProfileController.phoneController.text
                                .trim());
                      },
                      text: "Update",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_12,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.white,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
