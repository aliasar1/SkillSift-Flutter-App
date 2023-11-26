// job_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/models/job_model.dart';

class JobController extends GetxController {
  CollectionReference jobs = FirebaseFirestore.instance.collection('jobs');

  RxList<Job> jobList = <Job>[].obs;

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
    await jobs.add(job.toMap());
    loadJobs();
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
