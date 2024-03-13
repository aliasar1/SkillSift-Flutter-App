import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/services/recruiter_api.dart';

import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/services/job_api.dart';

class AllJobsController extends GetxController {
  RxList<Job> jobList = <Job>[].obs;
  RxList<Company> companyList = <Company>[].obs;

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadAllJobs();
  }

  Future<void> loadAllJobs() async {
    try {
      toggleLoading();
      final List<Job> jobs = await JobApi.getAllJobs();
      for (var job in jobs) {
        final resp =
            await RecruiterApi.getRecruiterWithCompanyDetails(job.recruiterId);
        companyList.add(Company.fromJson(resp['company_id']));
      }
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
}
