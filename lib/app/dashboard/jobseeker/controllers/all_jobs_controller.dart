import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../core/constants/firebase.dart';
import '../../../../core/models/company_model.dart';
import '../../../../core/models/job_model.dart';

class AllJobsController extends GetxController {
  RxList<Job> allJobList = <Job>[].obs;
  RxList<Company> allComapnyList = <Company>[].obs;

  Rx<bool> isLoading = false.obs;

  Future<Company> getCompanyData(String id) async {
    var snap = await firestore.collection('companies').doc(id).get();
    var companyData = Company.fromJson(snap.data()!);
    return companyData;
  }

  @override
  void onInit() {
    super.onInit();
    loadAllJobs();
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

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

        allComapnyList.add(companyData);
        allJobList.add(job);
      }
    } catch (e) {
      print('Error loading all jobs: $e');
    } finally {
      toggleLoading();
    }
  }
}
