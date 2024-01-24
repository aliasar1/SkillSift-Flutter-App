import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../core/exports/constants_exports.dart';
import '../controllers/apply_job_controller.dart';

class ApplyJobScreen extends StatelessWidget {
  ApplyJobScreen({super.key, required this.jobId});

  final ApplyJobController applyController = Get.put(ApplyJobController());
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: LightTheme.white),
          backgroundColor: LightTheme.primaryColor,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "Apply For Job",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_12,
              vertical: Sizes.MARGIN_12,
            ),
            child: Obx(
              () {
                if (applyController.isLoading.value) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: LightTheme.primaryColor,
                      ),
                    ),
                  );
                } else {
                  return Form(
                    key: applyController.applyFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: applyController.nameController,
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
                                  color: LightTheme.primaryColorLightShade,
                                  width: 1),
                              borderRadius:
                                  BorderRadius.circular(Sizes.RADIUS_4),
                            ),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: LightTheme.primaryColorLightShade,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(Sizes.RADIUS_4),
                            ),
                            floatingLabelStyle: const TextStyle(
                              color: LightTheme.primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: Sizes.SIZE_20,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: LightTheme.primaryColorLightShade,
                                  width: 1),
                              borderRadius:
                                  BorderRadius.circular(Sizes.RADIUS_4),
                            ),
                            focusColor: LightTheme.primaryColor,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizes.RADIUS_4),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizes.RADIUS_4),
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
                          controller: applyController.phoneController,
                          cursorColor: LightTheme.primaryColorLightShade,
                          onSaved: (phone) {
                            applyController.phoneController.text =
                                phone!.number;
                          },
                        ),
                        const SizedBox(height: Sizes.SIZE_12),
                        CustomTextFormField(
                          controller: applyController.emailController,
                          labelText: 'Email',
                          prefixIconData: Icons.email,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email cannot be empty.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Sizes.SIZE_16),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  applyController.pickDocument(jobId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.MARGIN_12,
                                    vertical: Sizes.MARGIN_12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: LightTheme.primaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  height: 80,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Txt(
                                          textAlign: TextAlign.start,
                                          title: "Upload your latest CV",
                                          fontContainerWidth: double.infinity,
                                          textStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: LightTheme.black,
                                            fontSize: Sizes.TEXT_SIZE_16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.upload,
                                        color: LightTheme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => applyController.pickedCV != null
                                ? const Icon(Icons.check_box,
                                    color: Colors.green, size: 30)
                                : const Icon(Icons.dangerous,
                                    color: Colors.red, size: 30)),
                          ],
                        ),
                        const SizedBox(height: Sizes.HEIGHT_14),
                        CustomButton(
                          buttonType: ButtonType.loading,
                          isLoading: applyController.isButtonLoading.value,
                          color: LightTheme.primaryColor,
                          loadingWidget: applyController.isButtonLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: LightTheme.white,
                                  ),
                                )
                              : null,
                          onPressed: () {
                            applyController.applyForJob(jobId);
                            Get.back();
                          },
                          constraints: const BoxConstraints(
                              maxHeight: 55, minHeight: 55),
                          text: "Apply",
                          hasInfiniteWidth: true,
                          textColor: LightTheme.whiteShade2,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
