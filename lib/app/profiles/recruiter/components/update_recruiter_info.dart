import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/profiles/recruiter/controllers/recruiter_profile_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/models/recruiter_model.dart';

class UpdateRecruiterDetailsForm extends StatefulWidget {
  const UpdateRecruiterDetailsForm(
      {super.key,
      required this.recruiterProfileController,
      required this.recruiter});

  final RecruiterProfileController recruiterProfileController;
  final Recruiter recruiter;

  @override
  State<UpdateRecruiterDetailsForm> createState() =>
      _UpdateRecruiterDetailsFormState();
}

class _UpdateRecruiterDetailsFormState
    extends State<UpdateRecruiterDetailsForm> {
  @override
  void initState() {
    super.initState();
    widget.recruiterProfileController.nameController.text =
        widget.recruiter.fullname;
    widget.recruiterProfileController.phoneController.text =
        widget.recruiter.contactNo;
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
              widget.recruiterProfileController.clearFields();
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
            child: Column(
              children: [
                CustomTextFormField(
                  controller: widget.recruiterProfileController.nameController,
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
                  controller: widget.recruiterProfileController.phoneController,
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
                        widget.recruiterProfileController.isLoading2.value,
                    buttonType: ButtonType.loading,
                    loadingWidget:
                        widget.recruiterProfileController.isLoading2.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: LightTheme.primaryColor,
                                ),
                              )
                            : null,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await widget.recruiterProfileController.updateInfo(
                          widget.recruiterProfileController.nameController.text
                              .trim(),
                          widget.recruiterProfileController.phoneController.text
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
