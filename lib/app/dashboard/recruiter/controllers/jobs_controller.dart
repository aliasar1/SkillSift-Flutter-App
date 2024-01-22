import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/company_model.dart';
import '../../../../core/models/job_model.dart';

class JobController extends GetxController with CacheManager {
  CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');

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

  Future<Company> getCompanyData(String id) async {
    var snap = await firestore.collection('companies').doc(id).get();
    var companyData = Company.fromJson(snap.data()!);
    return companyData;
  }

  RxList<Job> allJobList = <Job>[].obs;
  RxList<Company> allCompanyList = <Company>[].obs;

  Future<void> loadAllJobs() async {
    try {
      toggleLoading();
      var snapshot = await firestore.collectionGroup('jobsAdded').get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        String companyId = doc['companyId'];
        String jobId = doc.reference.id;

        Map<String, dynamic> jobData = doc.data() as Map<String, dynamic>;

        Job job = Job.fromMap(jobId, jobData);
        var companyData = await getCompanyData(companyId);

        allCompanyList.add(companyData);
        allJobList.add(job);
      }
    } catch (e) {
      print('Error loading all jobs: $e');
    } finally {
      toggleLoading();
    }
  }

  // late final Company comapnyData;

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

  RxList<String> skillsRequiredController = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadJobs(firebaseAuth.currentUser!.uid);
    loadAllJobs();
  }

  Future<void> loadJobs(String userId) async {
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

  Future<void> addJob(
      String title,
      String description,
      String qualification,
      String mode,
      String industry,
      String minSalary,
      String maxSalary,
      String jobType,
      String expReq) async {
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
          'jobType': jobType,
          'creationDateTime': DateTime.now(),
          'experienceReq': expReq,
          'companyId': getCompanyId()!
        });

        String jobId = jobRef.id;
        jobRef.update({'jobId': jobId});

        toggleLoading();
        allJobList.clear();
        allCompanyList.clear;
        jobList.clear();
        loadAllJobs();
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
    String maxSalary,
    String jobType,
    DateTime creationDateTime,
    String expReq,
  ) async {
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
            jobAddedBy: firebaseAuth.currentUser!.uid,
            jobType: jobType,
            creationDateTime: creationDateTime,
            experienceReq: expReq,
            companyId: getCompanyId()!);
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
        allJobList.clear();
        allCompanyList.clear;
        jobList.clear();
        loadAllJobs();
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

  Future<void> deleteJob(String jobId, int index) async {
    try {
      await firestore
          .collection('jobs')
          .doc(getCompanyId())
          .collection('jobsAdded')
          .doc(jobId)
          .delete();

      jobList.removeWhere((job) => job.jobId == jobId);
      allCompanyList.removeAt(index);
      allJobList.removeWhere((job) => job.jobId == jobId);
      allJobList.clear();
      allCompanyList.clear;
      jobList.clear();
      loadAllJobs();
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
