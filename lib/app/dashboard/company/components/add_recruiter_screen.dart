import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/models/recruiter_model.dart';
import '../controllers/recruiter_controller.dart';

class AddRecruiterScreen extends StatefulWidget {
  const AddRecruiterScreen(
      {super.key,
      required this.isEdit,
      this.recruiter,
      required this.controller});

  final bool isEdit;
  final Recruiter? recruiter;
  final RecruiterController controller;

  @override
  State<AddRecruiterScreen> createState() => _AddRecruiterScreenState();
}

class _AddRecruiterScreenState extends State<AddRecruiterScreen> {
  late final RecruiterController recruiterController;

  @override
  void initState() {
    recruiterController = widget.controller;
    if (widget.isEdit) {
      final recruiter = widget.recruiter!;
      recruiterController.nameController.text = recruiter.fullName;
      recruiterController.employeeIdController.text = recruiter.employeeId;
      recruiterController.roleController.text = recruiter.role;
      recruiterController.emailController.text = recruiter.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: LightTheme.white),
            onPressed: () {
              Get.back();
              recruiterController.clearFields();
            },
          ),
          title: Txt(
            title: widget.isEdit ? "Edit Recruiter" : "Add Recruiter",
            fontContainerWidth: double.infinity,
            textAlign: TextAlign.start,
            textStyle: const TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: Sizes.MARGIN_12,
            horizontal: Sizes.MARGIN_14,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: recruiterController.addFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: recruiterController.nameController,
                    labelText: 'Full Name',
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
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
                    controller: recruiterController.employeeIdController,
                    labelText: 'Employee Id',
                    autofocus: false,
                    readOnly: widget.isEdit,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.numbers,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Employee Id cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: recruiterController.roleController,
                    labelText: 'Role',
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Role cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: recruiterController.emailController,
                    labelText: AppStrings.EMAIL_ADDRESS,
                    readOnly: widget.isEdit,
                    autofocus: false,
                    hintText: "abc@gmail.com",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
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
                    () => CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.loading,
                      isLoading: recruiterController.isLoading.value,
                      loadingWidget: recruiterController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: LightTheme.primaryColor,
                              ),
                            )
                          : null,
                      onPressed: () {
                        widget.isEdit
                            ? recruiterController.updateRecruiter(
                                widget.recruiter!.uid,
                                recruiterController.nameController.text.trim(),
                                recruiterController.roleController.text.trim())
                            : recruiterController.addRecruiter(
                                recruiterController.nameController.text.trim(),
                                recruiterController.employeeIdController.text
                                    .trim(),
                                recruiterController.roleController.text.trim(),
                                recruiterController.emailController.text.trim(),
                                firebaseAuth.currentUser!.uid,
                              );
                      },
                      text: widget.isEdit ? "Edit" : "Add",
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
            ),
          ),
        ),
      ),
    );
  }
}
