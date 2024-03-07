import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../../core/constants/firebase.dart';
import '../../../../core/helpers/encryption.dart';
import '../../../../core/services/recruiter_api.dart';
import '../../../../core/services/upload_api.dart';

class RecruiterProfileController extends GetxController with CacheManager {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoading2 = false.obs;
  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get profilePhoto => _pickedImage.value;

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;
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

  final editPassFormKey = GlobalKey<FormState>();

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

  // Future<void> updateInfo(String name, String phone) async {
  //   try {
  //     toggleLoading2();
  //     await firestore
  //         .collection('companies')
  //         .doc(getCompanyId())
  //         .collection("recruiters")
  //         .doc(_uid.value)
  //         .update({'fullName': name, 'phone': phone});
  //     _nameRx.value = name;
  //     Get.offAll(RecruiterProfileScreen());
  //     Get.snackbar('Success', 'Info updated successfully.');
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //     toggleLoading2();
  //   }
  // }

  // void updatePassword(String? email, String oldPass, String newPassword) async {
  //   if (editPassFormKey.currentState!.validate()) {
  //     editPassFormKey.currentState!.save();
  //     try {
  //       toggleLoading2();
  //       UserCredential userCred = await firebaseAuth.signInWithEmailAndPassword(
  //           email: email!, password: oldPass);
  //       User? user = firebaseAuth.currentUser;
  //       if (user != null) {
  //         await userCred.user!.updatePassword(newPassword);
  //         DocumentSnapshot snap = await firestore
  //             .collection('users')
  //             .doc(firebaseAuth.currentUser!.uid)
  //             .get();
  //         final companyId = snap['verifiedBy'];

  //         final salt = Encryption.generateRandomKey(16);
  //         Encrypted encryptedPass = Encryption.encrypt(salt, newPassword);

  //         await firestore
  //             .collection('companies')
  //             .doc(companyId)
  //             .collection('recruiters')
  //             .doc(firebaseAuth.currentUser!.uid)
  //             .update(
  //           {
  //             'isPassChanged': true,
  //             'pass': {'salt': salt, 'encryptedPass': encryptedPass.base64},
  //           },
  //         );
  //         Get.snackbar(
  //           'Password Updated',
  //           'Password is successfully updated.',
  //         );
  //         Get.offAll(RecruiterProfileScreen());
  //       } else {
  //         Get.snackbar(
  //           'User not found',
  //           'Please provide correct credentials.',
  //         );
  //       }
  //       toggleLoading2();
  //     } catch (e) {
  //       toggleLoading2();
  //       Get.snackbar(
  //         'Error signing up',
  //         e.toString(),
  //       );
  //     }
  //   }
  // }
}
