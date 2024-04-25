import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/application_model.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';
import 'package:skillsift_flutter_app/core/services/application_api.dart';
import 'package:skillsift_flutter_app/core/services/upload_api.dart';

import '../../../core/models/level1_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/level1_api.dart';
import '../../../core/services/parse_files_api.dart';

class ApplyJobController extends GetxController with CacheManager {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isButtonLoading = false.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

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

  void pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pickedDocument = File(result.files.single.path!);
      _pickedDoc.value = pickedDocument;
      update();
    }
  }

  void applyForJob(String jobId, String jobJsonUrl) async {
    if (applyFormKey.currentState!.validate()) {
      try {
        toggleButtonLoading();
        String jobseekerId = getId()!;
        String applicationStatus = 'pending';
        String currentLevel = '1';

        Application application = Application(
            jobId: jobId,
            jobseekerId: jobseekerId,
            applicationStatus: applicationStatus,
            currentLevel: currentLevel,
            cvUrl: '');

        var app = await ApplicationApi.apply(application);
        final url = await UploadApi.uploadFile(
            "jobs_${jobId}_applications", _pickedDoc.value!.path, app.id!);
        await ApplicationApi.updateCVUrl(app.id!, url);
        // final resp = await NlpApi.processCVToRate(url, jobJsonUrl);
        // resp['score']
        Level1 l1 =
            Level1(applicationId: app.id!, score: 0.0, status: 'pending');
        await Level1Api.createLevel1(l1);
        Get.back();
        Get.snackbar('Application Submitted',
            'You have successfully applied for the job.');
      } catch (e) {
        Get.snackbar('Error', e.toString());
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
