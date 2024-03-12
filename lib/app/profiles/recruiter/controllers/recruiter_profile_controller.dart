import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';

import '../../../../core/services/recruiter_api.dart';
import '../../../../core/services/upload_api.dart';
import '../views/recruiter_profile_screen.dart';

class RecruiterProfileController extends GetxController with CacheManager {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoading2 = false.obs;
  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get profilePhoto => _pickedImage.value;

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _nameRx = "".obs;
  final Rx<String> _phoneRx = "".obs;
  String get userName => _nameRx.value;
  String get userPhone => _phoneRx.value;

  Rx<bool> isObscure1 = true.obs;
  Rx<bool> isObscure2 = true.obs;
  Rx<bool> isObscure3 = true.obs;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newRePasswordController = TextEditingController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  GlobalKey<FormState> editPassFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editInfoKey = GlobalKey<FormState>();

  void clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    newRePasswordController.clear();
    nameController.clear();
    phoneController.clear();
    isLoading.value = false;
    isLoading2.value = false;
  }

  void toggleVisibility1() {
    isObscure1.value = !isObscure1.value;
  }

  void toggleVisibility2() {
    isObscure2.value = !isObscure2.value;
  }

  void toggleVisibility3() {
    isObscure3.value = !isObscure3.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleLoading2() {
    isLoading2.value = !isLoading2.value;
  }

  Future<void> pickProfile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        _pickedImage.value = file;
        _uploadToStorage();
      }
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    }
  }

  Future<void> _uploadToStorage() async {
    String id = getId()!;
    final url = await UploadApi.uploadFile(
        "profiles_recruiters", _pickedImage.value!.path, id);
    final response = await RecruiterApi.updateProfileUrl(id, url);
    if (response.containsKey('error')) {
      Get.snackbar(
        'Error!',
        response['error'],
      );
    } else {
      Get.snackbar(
        'Success!',
        response['message'],
      );
    }
  }

  Future<void> updateInfo(String name, String phone) async {
    try {
      if (editInfoKey.currentState!.validate()) {
        toggleLoading2();
        final response =
            await RecruiterApi.updateRecruiterInfo(getId()!, name, phone);
        _nameRx.value = response['fullname'];
        Get.offAll(RecruiterProfileScreen(
          recruiter: Recruiter.fromJson(response),
        ));
        Get.snackbar('Success', 'Info updated successfully.');
      }
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    } finally {
      toggleLoading2();
    }
  }

  void updatePassword(String id, String oldPass, String newPassword) async {
    try {
      if (editPassFormKey.currentState!.validate()) {
        editPassFormKey.currentState!.save();
        final response =
            await RecruiterApi.updatePassword(id, oldPass, newPassword);
        if (!response.containsKey('error')) {
          Get.back();
          Get.snackbar(
            'Password Updated',
            'Password is successfully updated.',
          );
        } else {
          Get.snackbar(
            'Invalid',
            response['error'],
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      toggleLoading2();
    }
  }
}
