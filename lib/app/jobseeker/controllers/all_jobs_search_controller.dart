import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/jobseeker/controllers/all_jobs_controller.dart';

import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/services/recruiter_api.dart';

class AllJobsSearchController extends GetxController {
  final Rx<List<Job>> _searchedJobs = Rx<List<Job>>([]);
  List<Job> get searchedJobs => _searchedJobs.value;

  RxList<Company> companyList = <Company>[].obs;

  Future<void> searchJob(String typedUser, AllJobsController controller) async {
    if (typedUser.isEmpty) {
      _searchedJobs.value = [];
      companyList.clear();
      controller.jobList.clear();
      controller.companyList.clear();
      await controller.loadAllJobs();
      return;
    }

    List<Job> retVal = [];
    List<Company> companies = [];
    List<Job> jobsCopy = List.from(controller.jobList);
    for (var job in jobsCopy) {
      if (job.title.toLowerCase().contains(typedUser.toLowerCase())) {
        final resp =
            await RecruiterApi.getRecruiterWithCompanyDetails(job.recruiterId);
        companies.add(Company.fromJson(resp['company_id']));
        retVal.add(job);
      }
    }

    _searchedJobs.value = retVal;
    companyList.assignAll(companies);
  }
}
