import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/profiles/jobseeker/controllers/jobseeker_profile_controller.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';

class UpdateJobseekerDetailsForm extends StatefulWidget {
  const UpdateJobseekerDetailsForm({
    super.key,
    required this.jobseekerProfileController,
    required this.jobseeker,
  });

  final JobseekerProfileController jobseekerProfileController;
  final JobSeeker jobseeker;

  @override
  State<UpdateJobseekerDetailsForm> createState() =>
      _UpdateJobseekerDetailsFormState();
}

class _UpdateJobseekerDetailsFormState
    extends State<UpdateJobseekerDetailsForm> {
  @override
  void initState() {
    super.initState();
    widget.jobseekerProfileController.nameController.text =
        widget.jobseeker.fullname;
    widget.jobseekerProfileController.phoneController.text =
        widget.jobseeker.contactNo;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Get.back();
              widget.jobseekerProfileController.clearFields();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
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
            key: widget.jobseekerProfileController.editInfoKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: widget.jobseekerProfileController.nameController,
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
                const SizedBox(height: Sizes.SIZE_16),
                CustomTextFormField(
                  controller: widget.jobseekerProfileController.phoneController,
                  labelText: "Contact Number",
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  prefixIconData: Icons.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Number cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Sizes.HEIGHT_18),
                Obx(
                  () => CustomButton(
                    color: LightTheme.primaryColor,
                    hasInfiniteWidth: true,
                    isLoading:
                        widget.jobseekerProfileController.isLoading2.value,
                    buttonType: ButtonType.loading,
                    loadingWidget:
                        widget.jobseekerProfileController.isLoading2.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: LightTheme.primaryColor,
                                ),
                              )
                            : null,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await widget.jobseekerProfileController.updateInfo(
                          widget.jobseekerProfileController.nameController.text
                              .trim(),
                          widget.jobseekerProfileController.phoneController.text
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
          ),
        ),
      ),
    );
  }
}
