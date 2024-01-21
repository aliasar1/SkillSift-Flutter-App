import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/profile/company/controllers/company_profile_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';

class UpdateCompanyPassword extends StatelessWidget {
  const UpdateCompanyPassword({super.key, required this.profileController});

  final CompanyProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
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
          key: profileController.updatePasswordFormKey,
          child: Column(
            children: [
              Obx(
                () => CustomTextFormField(
                  controller: profileController.oldPassController,
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
                  controller: profileController.passController,
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
                      return "New password cannot be empty.";
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
                  controller: profileController.confirmPassController,
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
                      return "New password cannot be empty.";
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
                  isLoading: profileController.isLoading.value,
                  loadingWidget: profileController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: LightTheme.white,
                            backgroundColor: LightTheme.white,
                          ),
                        )
                      : null,
                  onPressed: () {
                    profileController.changePassword(
                        profileController.oldPassController.text.trim(),
                        profileController.passController.text.trim(),
                        profileController.confirmPassController.text.trim());
                  },
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