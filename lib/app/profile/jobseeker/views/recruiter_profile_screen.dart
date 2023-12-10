import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/profile/jobseeker/controllers/profile_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/exports/constants_exports.dart';

class RecruiterProfileScreen extends StatelessWidget {
  RecruiterProfileScreen({Key? key}) : super(key: key);

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
                  color: LightTheme.whiteShade2,
                ),
              ),
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: Sizes.HEIGHT_20,
                ),
                Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 64,
                        backgroundImage: profileController.profilePhoto != null
                            ? Image.file(profileController.profilePhoto!).image
                            : profileController.user['profilePhoto'] != ""
                                ? Image.network(
                                        profileController.user['profilePhoto'])
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
                const SizedBox(
                  height: Sizes.HEIGHT_14,
                ),
                Obx(
                  () => Txt(
                    textAlign: TextAlign.center,
                    title: profileController.nameController.text == ""
                        ? profileController.user['full']
                        : profileController.nameController.text,
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
                    profileController.nameController.text =
                        profileController.user['phone'];
                    _showUpdateProfileDialog(profileController, context);
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
                const ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: LightTheme.secondaryColor,
                  ),
                  title: Txt(
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
                const ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: LightTheme.secondaryColor,
                  ),
                  title: Txt(
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

  Future<dynamic> _showUpdateProfileDialog(
      ProfileController controller, BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    print(controller.nameController.text);
    print(controller.phoneController.text);
    return Get.defaultDialog(
      title: "Edit Personal Details",
      titleStyle: const TextStyle(
          color: LightTheme.black,
          fontWeight: FontWeight.bold,
          fontSize: Sizes.TEXT_SIZE_24),
      titlePadding: const EdgeInsets.symmetric(
          vertical: Sizes.PADDING_12, horizontal: Sizes.PADDING_12),
      radius: 5,
      content: Form(
        key: controller.editInfoFormKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.nameController,
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
            CustomTextFormField(
              controller: controller.phoneController,
              labelText: 'Phone Number',
              maxLines: 1,
              prefixIconData: Icons.phone,
              textInputAction: TextInputAction.next,
              autofocus: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone number cannot be empty.';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.HEIGHT_10),
            CustomButton(
              color: LightTheme.primaryColor,
              loadingWidget: controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: LightTheme.white,
                      ),
                    )
                  : null,
              onPressed: () {
                // profileController.updateUser(
                //   profileController.nameController.text.trim(),
                //   profileController.phoneController.text.trim(),
                //   profileController.addressController.text.trim(),
                // );
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
}
