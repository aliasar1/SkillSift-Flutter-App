import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';
import '../../../../core/models/job_model.dart';

class JobController extends GetxController {
  CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');

  RxList<Job> jobList = <Job>[].obs;
  Rx<bool> isLoading = false.obs;
  final addJobsFormKey = GlobalKey<FormState>();

  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final skillRequiredController = [];
  final qualificationRequiredController = TextEditingController();
  final modeController = TextEditingController();
  final jobIndustryController =
      TextEditingController(text: 'Information Technology');
  final minSalary = TextEditingController();
  final maxSalary = TextEditingController();

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

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

  Future<void> addJob(Job job) async {
    try {
      if (addJobsFormKey.currentState!.validate()) {
        addJobsFormKey.currentState!.save();
        toggleLoading();
        await firestore
            .collection('jobs')
            .doc('companyId')
            .collection('jobsByRecruiters')
            .doc(firebaseAuth.currentUser!.uid)
            .set({});
      }
    } catch (e) {
      print(e);
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
