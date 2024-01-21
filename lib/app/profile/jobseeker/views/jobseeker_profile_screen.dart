import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skillsift_flutter_app/app/profile/jobseeker/controllers/profile_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../notifications/views/notifications_screen.dart';

class JobseekerProfileScreen extends StatelessWidget {
  JobseekerProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.MARGIN_12,
        vertical: Sizes.MARGIN_12,
      ),
      child: Obx(
        () {
          if (profileController.isLoading.value) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: Sizes.HEIGHT_20,
                ),
                Center(
                  child: Stack(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 64,
                          backgroundImage: profileController.profilePhoto !=
                                  null
                              ? Image.file(profileController.profilePhoto!)
                                  .image
                              : profileController.user['profilePhoto'] != ""
                                  ? Image.network(profileController
                                          .user['profilePhoto'])
                                      .image
                                  : const NetworkImage(
                                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                          backgroundColor: LightTheme.blackShade4,
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () => profileController.pickImage(),
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: LightTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                Obx(
                  () => Txt(
                    textAlign: TextAlign.center,
                    title: profileController.userName == ""
                        ? profileController.user['full']
                        : profileController.userName,
                    fontContainerWidth: double.infinity,
                    textStyle: const TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_8,
                ),
                Txt(
                  textAlign: TextAlign.center,
                  title: profileController.user['email'],
                  fontContainerWidth: double.infinity,
                  textStyle: const TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                ),
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                ListTile(
                  onTap: () {
                    profileController.nameController.text =
                        profileController.user['full'];
                    profileController.phoneController.text =
                        profileController.user['phone'];
                    _showUpdateProfileDialog(context);
                  },
                  leading: const Icon(
                    Icons.person,
                    color: LightTheme.secondaryColor,
                  ),
                  title: const Txt(
                    textAlign: TextAlign.left,
                    title: 'Update profile details',
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    buildUpdatePassDialog(profileController, context);
                  },
                  leading: const Icon(
                    Icons.lock,
                    color: LightTheme.secondaryColor,
                  ),
                  title: const Txt(
                    textAlign: TextAlign.left,
                    title: 'Update password',
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(const NotificationsScreen());
                  },
                  leading: const Icon(
                    Icons.notifications,
                    color: LightTheme.secondaryColor,
                  ),
                  title: const Txt(
                    textAlign: TextAlign.left,
                    title: 'Notifications',
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.question_mark,
                    color: LightTheme.secondaryColor,
                  ),
                  title: Txt(
                    textAlign: TextAlign.left,
                    title: 'FAQs',
                    fontContainerWidth: double.infinity,
                    textStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: LightTheme.secondaryColor,
                      fontSize: Sizes.TEXT_SIZE_16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Spacer(),
                const Txt(
                  textAlign: TextAlign.center,
                  title: 'Powered By SkillSift ©',
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.secondaryColor,
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<dynamic> _showUpdateProfileDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "Edit Personal Details",
      titleStyle: const TextStyle(
        color: LightTheme.black,
        fontWeight: FontWeight.bold,
        fontSize: Sizes.TEXT_SIZE_24,
      ),
      titlePadding: const EdgeInsets.symmetric(
        vertical: Sizes.PADDING_12,
        horizontal: Sizes.PADDING_12,
      ),
      radius: 5,
      content: Form(
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
    );
  }

  Future<dynamic> buildUpdatePassDialog(
      ProfileController controller, BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Get.defaultDialog(
      title: "Change Password",
      titleStyle: const TextStyle(
        color: LightTheme.black,
        fontWeight: FontWeight.bold,
        fontSize: Sizes.TEXT_SIZE_24,
      ),
      titlePadding: const EdgeInsets.symmetric(
        vertical: Sizes.PADDING_12,
        horizontal: Sizes.PADDING_12,
      ),
      radius: 5,
      content: Form(
        key: profileController.editPassFormKey,
        child: Column(
          children: [
            Obx(
              () => CustomTextFormField(
                controller: profileController.oldPasswordController,
                suffixIconData: controller.isObscure1.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility1,
                labelText: "Old Password",
                obscureText: controller.isObscure1.value,
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
                controller: controller.newPasswordController,
                labelText: "New Password",
                suffixIconData: controller.isObscure2.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility2,
                obscureText: controller.isObscure2.value,
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
                controller: controller.newRePasswordController,
                labelText: "Re-enter new password",
                suffixIconData: controller.isObscure3.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                onSuffixTap: controller.toggleVisibility3,
                obscureText: controller.isObscure3.value,
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
                isLoading: controller.isLoading.value,
                loadingWidget: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: LightTheme.white,
                          backgroundColor: LightTheme.white,
                        ),
                      )
                    : null,
                onPressed: () {
                  controller.changePassword(
                      controller.oldPasswordController.text.trim(),
                      controller.newPasswordController.text.trim(),
                      controller.newRePasswordController.text.trim());
                },
                text: "Change",
                hasInfiniteWidth: true,
                textColor: LightTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
