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
    jobDescriptionController.dispose();
    jobDescriptionController.dispose();
    qualificationRequiredController.dispose();
    chipController.dispose();
    modeController.dispose();
    jobIndustryController.dispose();
    maxSalary.dispose();
    maxSalary.dispose();
    skillsRequiredController.value = [];
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  RxList<String> skillsRequiredController = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadJobs();
  }

  Future<void> loadJobs() async {
    jobList.assignAll(await getJobs());
  }

  Future<List<Job>> getJobs() async {
    var snapshot = await jobs.get();
    return snapshot.docs.map((doc) {
      return Job.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
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
        clearFields();
        Get.back();
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

  Future<void> updateJob(Job job) async {
    await jobs.doc(job.jobId).update(job.toMap());
    loadJobs();
  }

  Future<void> deleteJob(String jobId) async {
    await jobs.doc(jobId).delete();
    loadJobs();
  }
}
