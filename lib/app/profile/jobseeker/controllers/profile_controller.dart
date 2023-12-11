import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/firebase.dart';

class ProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;

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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newRePasswordController = TextEditingController();

  final editPassFormKey = GlobalKey<FormState>();
  final editInfoFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    updateUserId(firebaseAuth.currentUser!.uid);
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

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> getUserData() async {
    try {
      toggleLoading();
      DocumentSnapshot userDoc =
          await firestore.collection('jobseekers').doc(_uid.value).get();
      if (userDoc.exists) {
        _user.value = userDoc.data()! as dynamic;
        update();
      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      toggleLoading();
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedImage.value = File(pickedImage!.path);
    String downloadUrl = await _uploadToStorage(_pickedImage.value!);
    await firestore
        .collection('jobseekers')
        .doc(_uid.value)
        .update({'profilePhoto': downloadUrl}).whenComplete(() {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture.');
    });
    update();
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePictures')
        .child('jobseekers')
        .child(_uid.value);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  updateUserProfile(String newName, String newPhone) async {
    if (editInfoFormKey.currentState!.validate()) {
      editInfoFormKey.currentState!.save();
      toggleLoading();
      await firestore.collection('jobseekers').doc(_uid.value).update({
        'full': newName,
        'phone': newPhone,
      }).whenComplete(() {
        toggleLoading();
        getUserData();
        _nameRx.value = newName;
        _phoneRx.value = newPhone;
        Get.back();
        clearFields();
        Get.snackbar('User details updated!',
            'You have successfully updated your details!');
      });
    }
  }

  void changePassword(
      String currentPass, String newPass, String newRePass) async {
    if (newPass == newRePass) {
      if (editPassFormKey.currentState!.validate()) {
        editPassFormKey.currentState!.save();
        toggleLoading();
        try {
          final cred = EmailAuthProvider.credential(
              email: firebaseAuth.currentUser!.email!, password: currentPass);
          await firebaseAuth.currentUser!.reauthenticateWithCredential(cred);
          await firebaseAuth.currentUser!.updatePassword(newPass);
          Get.snackbar('Password updated successfully!',
              'You have successfully updated your password.');
          toggleLoading();
          Get.back();
          clearFields();
        } catch (error) {
          toggleLoading();
          Get.snackbar('Password updated failed!', error.toString());
        }
      }
    } else {
      toggleLoading();
      Get.snackbar('Error!', 'Password does not match.');
    }
  }

  void clearFields() {
    nameController.clear();
    phoneController.clear();
    newPasswordController.clear();
    oldPasswordController.clear();
    newRePasswordController.clear();
  }
}
