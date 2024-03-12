import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/app/recruiter/views/recruiter_dashboard.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import '../../../../core/models/job_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/job_api.dart';
import '../../../core/services/upload_api.dart';

class JobController extends GetxController with CacheManager {
  RxList<Job> jobList = <Job>[].obs;

  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> addJobsFormKey = GlobalKey<FormState>();

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
  final deadlineController = TextEditingController();

  final Rx<File?> _pickedDoc = Rx<File?>(null);
  File? get pickedJD => _pickedDoc.value;

  String downloadUrl = "";
  String timeStamp = "";

  late DateTime? deadline;

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
    deadline = null;
    _pickedDoc.value = null;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  RxList<String> skillsRequiredController = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAllJobs();
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        _pickedDoc.value = file;
      }
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    }
  }

  Future<void> loadAllJobs() async {
    try {
      toggleLoading();
      final List<Job> jobs = await JobApi.getAllJobs();
      jobList.addAll(jobs);
      toggleLoading();
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    }
  }

  Future<void> addJob(
    String title,
    String description,
    List<String> tags,
    String qualification,
    String experience,
    String mode,
    String jobType,
    String industry,
    String minSalary,
    String maxSalary,
    String recruiterId,
    DateTime deadline,
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
          String formattedDeadline = DateFormat('dd-MM-yyyy').format(deadline);
          final resp = await JobApi.addJob(
            title: title,
            description: description,
            tags: tags,
            qualification: qualification,
            expReq: experience,
            mode: mode,
            jobType: jobType,
            industry: industry,
            minSalary: double.parse(minSalary),
            maxSalary: double.parse(maxSalary),
            recruiterId: recruiterId,
            deadline: formattedDeadline,
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
                "jobs_$jobId", _pickedDoc.value!.path, jobId);
            final response = await JobApi.updateJobUrl(jobId, url);

            Job newJob = Job.fromJson(response['job']);
            jobList.add(newJob);
            toggleLoading();
            Get.back();
            clearFields();
            Get.snackbar(
              'Success!',
              'Job added successfully.',
            );
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

  Future<void> updateJob(
    String jobId,
    String title,
    String description,
    List<String> tags,
    String qualification,
    String experience,
    String mode,
    String jobType,
    String industry,
    String minSalary,
    String maxSalary,
    DateTime deadline,
  ) async {
    try {
      if (addJobsFormKey.currentState!.validate()) {
        addJobsFormKey.currentState!.save();
        toggleLoading();
        String formattedDeadline = DateFormat('dd-MM-yyyy').format(deadline);
        final resp = await JobApi.updateJob(
          jobId: jobId,
          title: title,
          description: description,
          tags: tags,
          qualification: qualification,
          experience: experience,
          mode: mode,
          jobType: jobType,
          industry: industry,
          minSalary: double.parse(minSalary),
          maxSalary: double.parse(maxSalary),
          deadline: formattedDeadline,
        );
        if (resp.containsKey('error')) {
          Get.snackbar(
            'Error!',
            'Error updating job, try later.',
          );
          toggleLoading();
          return;
        }
        Job updatedJob = Job.fromJson(resp);

        int index = jobList.indexWhere((job) => job.id == updatedJob.id);

        if (index != -1) {
          jobList[index] = updatedJob;
          toggleLoading();
          final response = await AuthApi.getCurrentUser(true, getId()!);
          final recruiter = Recruiter.fromJson(response);
          Get.offAll(RecruiterDashboard(recruiter: recruiter));
          clearFields();
          Get.snackbar(
            'Success!',
            'Job updated successfully.',
          );
        } else {
          Get.snackbar(
            'Error!',
            'Job not found in the list.',
          );
          toggleLoading();
          return;
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

  Future<void> deleteJob(String jobId) async {
    try {
      final resp = await JobApi.deleteJob(jobId);
      if (resp['success'] == true) {
        jobList.removeWhere((job) => job.id == jobId);
        final response = await AuthApi.getCurrentUser(true, getId()!);
        final recruiter = Recruiter.fromJson(response);
        Get.offAll(RecruiterDashboard(recruiter: recruiter));
        Get.snackbar(
          'Success!',
          'Job deleted successfully.',
        );
      } else {
        Get.snackbar(
          'Error!',
          'Failed to delete job.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failure!',
        e.toString(),
      );
    }
  }
}
