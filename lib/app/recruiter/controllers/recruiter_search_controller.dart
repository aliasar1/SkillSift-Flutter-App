import 'package:get/get.dart';

import '../../../core/models/job_model.dart';
import '../../jobs/controllers/job_controller.dart';

class RecruiterJobsSearchController extends GetxController {
  final Rx<List<Job>> _searchedJobs = Rx<List<Job>>([]);
  List<Job> get searchedJobs => _searchedJobs.value;

  Future<void> searchJob(String typedUser, JobController controller) async {
    if (typedUser.isEmpty) {
      _searchedJobs.value = [];
      controller.jobList.clear();
      controller.loadAllJobs();
      return;
    }

    List<Job> retVal = [];

    for (var job in controller.jobList) {
      if (job.title.toLowerCase().contains(typedUser.toLowerCase())) {
        retVal.add(job);
      }
    }

    _searchedJobs.value = retVal;
  }
}
