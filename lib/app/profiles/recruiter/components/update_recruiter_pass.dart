import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../controllers/recruiter_profile_controller.dart';

class UpdateRecruiterPass extends StatelessWidget {
  const UpdateRecruiterPass(
      {super.key, required this.profileController, required this.recruiter});

  final RecruiterProfileController profileController;
  final Recruiter recruiter;

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
            profileController.clearFields();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        iconTheme: const IconThemeData(color: LightTheme.white),
        backgroundColor: LightTheme.primaryColor,
        title: const Txt(
          textAlign: TextAlign.start,
          title: "Update Password",
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
          key: profileController.editPassFormKey,
          child: Column(
            children: [
              Obx(
                () => CustomTextFormField(
                  controller: profileController.oldPasswordController,
                  suffixIconData: profileController.isObscure1.value
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  onSuffixTap: profileController.toggleVisibility1,
                  labelText: "Old Password",
                  obscureText: profileController.isObscure1.value,
                  prefixIconData: Icons.lock,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Old password cannot be empty.";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => CustomTextFormField(
                  controller: profileController.newPasswordController,
                  labelText: "New Password",
                  suffixIconData: profileController.isObscure2.value
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  onSuffixTap: profileController.toggleVisibility2,
                  obscureText: profileController.isObscure2.value,
                  prefixIconData: Icons.key,
                  textInputAction: TextInputAction.next,
                  autofocus: false,
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
                height: 12,
              ),
              Obx(
                () => CustomTextFormField(
                  controller: profileController.newRePasswordController,
                  labelText: "Re-enter new password",
                  suffixIconData: profileController.isObscure3.value
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  onSuffixTap: profileController.toggleVisibility3,
                  obscureText: profileController.isObscure3.value,
                  prefixIconData: Icons.key,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value !=
                        profileController.newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => CustomButton(
                  color: LightTheme.primaryColor,
                  isLoading: profileController.isLoading2.value,
                  buttonType: ButtonType.loading,
                  loadingWidget: profileController.isLoading2.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: LightTheme.white,
                            backgroundColor: LightTheme.primaryColor,
                          ),
                        )
                      : null,
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    profileController.updatePassword(
                      recruiter.userId,
                      profileController.oldPasswordController.text.trim(),
                      profileController.newPasswordController.text.trim(),
                    );
                  },
                  constraints:
                      const BoxConstraints(maxHeight: 45, minHeight: 45),
                  buttonPadding: const EdgeInsets.all(0),
                  text: "Change",
                  hasInfiniteWidth: true,
                  textColor: LightTheme.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
