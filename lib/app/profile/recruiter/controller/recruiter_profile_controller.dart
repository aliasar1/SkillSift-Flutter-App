import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../../core/constants/firebase.dart';
import '../../../authentication/controllers/auth_controller.dart';

class RecruiterProfileController extends GetxController with CacheManager {
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

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newRePasswordController = TextEditingController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final editPassFormKey = GlobalKey<FormState>();

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
      DocumentSnapshot userDoc = await firestore
          .collection('companies')
          .doc(getCompanyId())
          .collection("recruiters")
          .doc(_uid.value)
          .get();
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
        .collection('companies')
        .doc(getCompanyId())
        .collection("recruiters")
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
        .child('recruiters')
        .child(_uid.value);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
