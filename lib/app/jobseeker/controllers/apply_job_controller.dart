import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/auth_api.dart';

class ApplyJobController extends GetxController with CacheManager {
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
    init();
  }

  void init() {
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      toggleLoading();
      final response = await AuthApi.getCurrentUser(false, getId()!);
      final jobseeker = JobSeeker.fromJson(response);

      nameController.text = jobseeker.fullname;
      phoneController.text = jobseeker.contactNo;
      emailController.text = jobseeker.email;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      toggleLoading();
    }
  }

  void pickDocument(String jobId) async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf'],
    // );

    // if (result != null) {
    //   File pickedDocument = File(result.files.single.path!);

    //   _pickedDoc.value = pickedDocument;
    //   downloadUrl = await _uploadToStorage(_pickedDoc.value!, jobId);

    //   Get.snackbar('CV Uploaded', 'You have successfully uploaded your CV.');
    //   update();
    // } else {
    //   Get.snackbar('No file selected', 'Please pick a PDF document.');
    // }
  }

  // Future<String> _uploadToStorage(File doc, String jobId) async {
  //   Reference ref =
  //       firebaseStorage.ref().child('cv').child(jobId).child(_uid.value);

  //   UploadTask uploadTask = ref.putFile(doc);
  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // void applyForJob(String jobId) async {
  //   if (applyFormKey.currentState!.validate()) {
  //     toggleButtonLoading();
  //     try {
  //       await firestore
  //           .collection('jobApplications')
  //           .doc(jobId)
  //           .collection("applicants")
  //           .doc(_uid.value)
  //           .set({
  //         "cvUrl": downloadUrl,
  //         "score": 0,
  //         "applicantId": _uid.value,
  //         "name": nameController.text,
  //         "phone": phoneController.text,
  //         "email": emailController.text
  //       });

  //       Get.snackbar('Application Submitted',
  //           'You have successfully applied for the job.');
  //     } catch (e) {
  //       print('Error applying for job: $e');
  //     } finally {
  //       toggleButtonLoading();
  //     }
  //   }
  // }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleButtonLoading() {
    isButtonLoading.value = !isButtonLoading.value;
  }
}
