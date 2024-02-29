import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/company_model.dart';
import '../../../../core/models/job_model.dart';
import '../../../core/services/job_api.dart';
import '../../../core/services/upload_api.dart';

class JobController extends GetxController with CacheManager {
  RxList<Job> jobList = <Job>[].obs;

  Rx<bool> isLoading = false.obs;
  final addJobsFormKey = GlobalKey<FormState>();

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();

  final qualificationRequiredController =
      TextEditingController(text: 'Undergraduate');
  final chipController = TextEditingController();
  final modeController = TextEditingController(text: 'Onsite');
  final jobIndustryController =
      TextEditingController(text: 'Information Technology');
  final minSalary = TextEditingController();
  final maxSalary = TextEditingController();
  final experienceReq = TextEditingController(text: '0-1 Years');
  final jobType = TextEditingController(text: 'Full Time');
  final jdUrl = TextEditingController();

  final Rx<File?> _pickedDoc = Rx<File?>(null);
  File? get pickedJD => _pickedDoc.value;

  String downloadUrl = "";
  String timeStamp = "";

  void clearFields() {
    jobTitleController.clear();
    jobDescriptionController.clear();
    qualificationRequiredController.clear();
    chipController.clear();
    modeController.clear();
    jobIndustryController.clear();
    minSalary.clear();
    maxSalary.clear();
    jobType.clear();
    skillsRequiredController.value = [];
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  RxList<Job> allJobList = <Job>[].obs;
  RxList<Company> allCompanyList = <Company>[].obs;

  late final Company comapnyData;

  RxList<String> skillsRequiredController = <String>[].obs;

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        _pickedDoc.value = file;

        print(_pickedDoc.value);
        // You can now use the formData in your API request
        // For example, send it using Dio
        // await dio.post('your_api_endpoint', data: formData);
      } else {
        // User canceled the file picker
        // Handle accordingly
      }
    } catch (e) {
      // Handle errors
      print('Error picking document: $e');
    }
  }

  Future<void> addJob(
    String title,
    String description,
    String qualification,
    String mode,
    String industry,
    String minSalary,
    String maxSalary,
    String jobType,
    String expReq,
    String recruiterId,
  ) async {
    try {
      if (addJobsFormKey.currentState!.validate()) {
        if (_pickedDoc.value == null) {
          Get.snackbar(
            'Error!',
            'Please upload job pdf document.',
          );
          return;
        } else {
          addJobsFormKey.currentState!.save();
          toggleLoading();

          final resp = await JobApi.addJob(
            title: title,
            description: description,
            qualification: qualification,
            mode: mode,
            industry: industry,
            minSalary: minSalary,
            maxSalary: maxSalary,
            jobType: jobType,
            expReq: expReq,
            recruiterId: recruiterId,
          );
          if (resp.containsKey('error')) {
            Get.snackbar(
              'Error!',
              'Error adding job, try later.',
            );
            toggleLoading();
            return;
          } else {
            String jobId = resp['_id'];
            final url = await UploadApi.uploadFile(
                "jobs_$jobId", _pickedDoc.value!.path);
            final response = await JobApi.updateJobUrl(jobId, url);
            Get.snackbar(
              'Success!',
              response['message'],
            );
            toggleLoading();
            clearFields();
            return;
          }
        }
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    }
  }

  // Future<void> updateJob(
  //     String jobId,
  //     String title,
  //     String description,
  //     String qualification,
  //     String mode,
  //     String industry,
  //     String minSalary,
  //     String maxSalary,
  //     String jobType,
  //     DateTime creationDateTime,
  //     String expReq,
  //     String jobUrl) async {
  //   try {
  //     if (addJobsFormKey.currentState!.validate()) {
  //       addJobsFormKey.currentState!.save();
  //       toggleLoading();
  //       Job updatedJob = Job(
  //           jobId: jobId,
  //           jobTitle: title,
  //           jobDescription: description,
  //           skillsRequired: skillsRequiredController,
  //           qualificationRequired: qualification,
  //           mode: mode,
  //           industry: industry,
  //           minSalary: minSalary,
  //           maxSalary: maxSalary,
  //           jobAddedBy: firebaseAuth.currentUser!.uid,
  //           jobType: jobType,
  //           creationDateTime: creationDateTime,
  //           experienceReq: expReq,
  //           jdUrl: jobUrl,
  //           companyId: getCompanyId()!);
  //       await firestore
  //           .collection('jobs')
  //           .doc(getCompanyId())
  //           .collection('jobsAdded')
  //           .doc(jobId)
  //           .update(updatedJob.toMap());
  //       var index =
  //           jobList.indexWhere((element) => element.jobId == updatedJob.jobId);
  //       if (index != -1) {
  //         jobList[index] = updatedJob;
  //       } else {
  //         Get.snackbar(
  //           'Failure!',
  //           'Cannot find the job with same id.',
  //         );
  //         return;
  //       }
  //       toggleLoading();
  //       allJobList.clear();
  //       allCompanyList.clear;
  //       jobList.clear();
  //       loadAllJobs();
  //       loadJobs(firebaseAuth.currentUser!.uid);
  //       Get.back();
  //       clearFields();
  //       Get.snackbar(
  //         'Success!',
  //         'Job updated successfully.',
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Failure!',
  //       e.toString(),
  //     );
  //   }
  // }

  // Future<void> deleteJob(String jobId, int index) async {
  //   try {
  //     await firestore
  //         .collection('jobs')
  //         .doc(getCompanyId())
  //         .collection('jobsAdded')
  //         .doc(jobId)
  //         .delete();

  //     jobList.removeWhere((job) => job.jobId == jobId);
  //     allCompanyList.removeAt(index);
  //     allJobList.removeWhere((job) => job.jobId == jobId);
  //     allJobList.clear();
  //     allCompanyList.clear;
  //     jobList.clear();
  //     loadAllJobs();
  //     loadJobs(firebaseAuth.currentUser!.uid);
  //     Get.snackbar(
  //       'Success!',
  //       'Job deleted successfully.',
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Failure!',
  //       e.toString(),
  //     );
  //   }
  // }
}
