import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import '../../../../core/models/job_model.dart';

class JobController extends GetxController with CacheManager {
  CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');

  RxList<Job> jobList = <Job>[].obs;
  Rx<bool> isLoading = false.obs;
  final addJobsFormKey = GlobalKey<FormState>();

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();

  final qualificationRequiredController = TextEditingController();
  final chipController = TextEditingController();
  final modeController = TextEditingController(text: 'Onsite');
  final jobIndustryController =
      TextEditingController(text: 'Information Technology');
  final minSalary = TextEditingController();
  final maxSalary = TextEditingController();

  void clearFields() {
    jobDescriptionController.clear();
    jobDescriptionController.clear();
    qualificationRequiredController.clear();
    chipController.clear();
    modeController.clear();
    jobIndustryController.clear();
    maxSalary.clear();
    maxSalary.clear();
    skillsRequiredController.value = [];
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  RxList<String> skillsRequiredController = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadJobs(firebaseAuth.currentUser!.uid);
  }

  void loadJobs(String userId) async {
    toggleLoading();
    var snapshot = await firestore
        .collection('jobs')
        .doc(getCompanyId())
        .collection('jobsAdded')
        .where('jobAddedBy', isEqualTo: userId)
        .get();

    jobList.assignAll(snapshot.docs.map((doc) {
      return Job.fromMap(doc.id, doc.data());
    }));
    toggleLoading();
  }

  Future<void> addJob(String title, String description, String qualification,
      String mode, String industry, String minSalary, String maxSalary) async {
    try {
      if (addJobsFormKey.currentState!.validate()) {
        addJobsFormKey.currentState!.save();
        toggleLoading();
        DocumentReference jobRef = await firestore
            .collection('jobs')
            .doc(getCompanyId())
            .collection('jobsAdded')
            .add({
          'jobTitle': title,
          'jobDescription': description,
          'skillsRequired': skillsRequiredController,
          'qualificationRequired': qualification,
          'mode': mode,
          'industry': industry,
          'minSalary': minSalary,
          'maxSalary': maxSalary,
          'jobAddedBy': firebaseAuth.currentUser!.uid,
        });

        String jobId = jobRef.id;
        jobRef.update({'jobId': jobId});

        toggleLoading();
        loadJobs(firebaseAuth.currentUser!.uid);
        Get.back();
        clearFields();
        Get.snackbar(
          'Success!',
          'Job added successfully.',
        );
      }
    } catch (e) {
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
      String qualification,
      String mode,
      String industry,
      String minSalary,
      String maxSalary) async {
    try {
      if (addJobsFormKey.currentState!.validate()) {
        addJobsFormKey.currentState!.save();
        toggleLoading();
        Job updatedJob = Job(
            jobId: jobId,
            jobTitle: title,
            jobDescription: description,
            skillsRequired: skillsRequiredController,
            qualificationRequired: qualification,
            mode: mode,
            industry: industry,
            minSalary: minSalary,
            maxSalary: maxSalary,
            jobAddedBy: firebaseAuth.currentUser!.uid);
        await firestore
            .collection('jobs')
            .doc(getCompanyId())
            .collection('jobsAdded')
            .doc(jobId)
            .update(updatedJob.toMap());
        var index =
            jobList.indexWhere((element) => element.jobId == updatedJob.jobId);
        if (index != -1) {
          jobList[index] = updatedJob;
        } else {
          Get.snackbar(
            'Failure!',
            'Cannot find the job with same id.',
          );
          return;
        }
        toggleLoading();
        loadJobs(firebaseAuth.currentUser!.uid);
        Get.back();
        clearFields();
        Get.snackbar(
          'Success!',
          'Job updated successfully.',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failure!',
        e.toString(),
      );
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      await firestore
          .collection('jobs')
          .doc(getCompanyId())
          .collection('jobsAdded')
          .doc(jobId)
          .delete();

      jobList.removeWhere((job) => job.jobId == jobId);
      loadJobs(firebaseAuth.currentUser!.uid);
      Get.snackbar(
        'Success!',
        'Job deleted successfully.',
      );
    } catch (e) {
      Get.snackbar(
        'Failure!',
        e.toString(),
      );
    }
  }
}
