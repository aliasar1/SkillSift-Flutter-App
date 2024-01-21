import 'package:get/get.dart';

import '../../../../core/constants/firebase.dart';
import '../../../../core/models/job_model.dart';

class CompanyAddedJobsController extends GetxController {
  Rx<bool> isLoading = false.obs;

  RxList<Job> jobList = <Job>[].obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadJobs();
  }

  void loadJobs() async {
    toggleLoading();
    var snapshot = await firestore
        .collection('jobs')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('jobsAdded')
        .get();

    jobList.assignAll(snapshot.docs.map((doc) {
      return Job.fromMap(doc.id, doc.data());
    }));
    toggleLoading();
  }
}
