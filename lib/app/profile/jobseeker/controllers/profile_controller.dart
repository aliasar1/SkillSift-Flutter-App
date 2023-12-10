import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final editPassFormKey = GlobalKey<FormState>();
  final editInfoFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    updateUserId(firebaseAuth.currentUser!.uid);
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
        .collection('users')
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
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
