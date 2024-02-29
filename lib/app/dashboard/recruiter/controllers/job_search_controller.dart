// import 'package:get/get.dart';
// import 'package:skillsift_flutter_app/app/dashboard/recruiter/controllers/jobs_controller.dart';
// import 'package:skillsift_flutter_app/core/constants/firebase.dart';

// import '../../../../core/models/company_model.dart';
// import '../../../../core/models/job_model.dart';

// class JobSearchController extends GetxController {
//   final Rx<List<Job>> _searchedJobs = Rx<List<Job>>([]);
//   List<Job> get searchedJobs => _searchedJobs.value;

//   final Rx<List<Company>> _searchJobCompany = Rx<List<Company>>([]);
//   List<Company> get searchJobCompany => _searchJobCompany.value;

//   Future<void> searchJob(
//       String typedUser, JobController allJobsController) async {
//     if (typedUser.isEmpty) {
//       _searchedJobs.value = [];
//       _searchJobCompany.value = [];
//       allJobsController.loadJobs(firebaseAuth.currentUser!.uid);
//       return;
//     }

//     List<Job> retVal = [];
//     List<Company> companyList = [];

//     for (var job in allJobsController.allJobList) {
//       print(job.jobTitle);
//       if (job.jobTitle.toLowerCase().contains(typedUser.toLowerCase())) {
//         retVal.add(job);
//         var companyData = await allJobsController.getCompanyData(job.companyId);
//         companyList.add(companyData);
//       }
//     }

//     _searchedJobs.value = retVal;
//     _searchJobCompany.value = companyList;
//   }
// }
