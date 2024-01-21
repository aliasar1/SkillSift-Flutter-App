import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';

class ApplyJobController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isButtonLoading = false.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  final applyFormKey = GlobalKey<FormState>();

  final Rx<File?> _pickedDoc = Rx<File?>(null);
  File? get pickedCV => _pickedDoc.value;

  String downloadUrl = "";

  @override
  void onInit() {
    super.onInit();
    updateUserId(firebaseAuth.currentUser!.uid);
  }

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      toggleLoading();
      DocumentSnapshot userDoc =
          await firestore.collection('jobseekers').doc(_uid.value).get();
      if (userDoc.exists) {
        _user.value = userDoc.data()! as Map<String, dynamic>;

        nameController.text = _user.value['full'] ?? '';
        phoneController.text = _user.value['phone'] ?? '';
        emailController.text = _user.value['email'] ?? '';

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

  void pickDocument(String jobId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pickedDocument = File(result.files.single.path!);

      _pickedDoc.value = pickedDocument;
      downloadUrl = await _uploadToStorage(_pickedDoc.value!, jobId);

      Get.snackbar('CV Uploaded', 'You have successfully uploaded your CV.');
      update();
    } else {
      Get.snackbar('No file selected', 'Please pick a PDF document.');
    }
  }

  Future<String> _uploadToStorage(File doc, String jobId) async {
    Reference ref =
        firebaseStorage.ref().child('cv').child(jobId).child(_uid.value);

    UploadTask uploadTask = ref.putFile(doc);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void applyForJob(String jobId) async {
    if (applyFormKey.currentState!.validate()) {
      toggleButtonLoading();
      try {
        await firestore
            .collection('jobApplications')
            .doc(jobId)
            .collection("applicants")
            .doc(_uid.value)
            .set({
          "cvUrl": downloadUrl,
          "score": 0,
          "applicantId": _uid.value,
          "name": nameController.text,
          "phone": phoneController.text,
          "email": emailController.text
        });

        Get.snackbar('Application Submitted',
            'You have successfully applied for the job.');
      } catch (e) {
        print('Error applying for job: $e');
      } finally {
        toggleButtonLoading();
      }
    }
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleButtonLoading() {
    isButtonLoading.value = !isButtonLoading.value;
  }
}
