import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/jobseeker/controllers/all_jobs_controller.dart';

import '../../../core/models/company_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/services/recruiter_api.dart';

class AllJobsSearchController extends GetxController {
  final Rx<List<Job>> _searchedJobs = Rx<List<Job>>([]);
  List<Job> get searchedJobs => _searchedJobs.value;

  RxList<Company> companyList = <Company>[].obs;

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

  Rx<double> min = Rx(0);
  Rx<double> max = Rx(30000);

  Rx<bool> isFilterApplied = false.obs;
  Rx<bool> isFilterResultEmpty = true.obs;

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

  Future<void> clearFilters(AllJobsController controller) async {
    qualificationRequiredController.text = 'Undergraduate';
    modeController.text = 'Onsite';
    jobIndustryController.text = 'Information Technology';
    experienceReq.text = '0-1 Years';
    jobType.text = 'Full Time';
    minSalary.clear();
    maxSalary.clear();
    min.value = 0;
    max.value = 30000;
    isFilterResultEmpty.value = true;
    isFilterApplied.value = false;
    _searchedJobs.value = [];
    companyList.clear();
    controller.jobList.clear();
    controller.companyList.clear();
    await controller.loadAllJobs();
  }

  Future<void> applyFilter(AllJobsController controller) async {
    List<Job> filteredJobs = [];
    List<Company> filteredCompanies = [];
    isFilterApplied.value = true;

    // Apply filters based on the selected criteria
    List<Job> jobsCopy = List.from(controller.jobList);
    for (var job in jobsCopy) {
      // Check for other filter criteria
      if (qualificationRequiredController.text == job.qualificationRequired &&
          job.mode == modeController.text &&
          job.industry == jobIndustryController.text &&
          job.type == jobType.text &&
          job.experienceRequired == experienceReq.text) {
        // print(
        //     "Qualification: ${qualificationRequiredController.text == job.qualificationRequired}");
        // print(
        //     "Mode: ${qualificationRequiredController.text == job.qualificationRequired}");
        // print("Type: ${job.type == jobType.text}");
        // print("Exp: ${job.experienceRequired == experienceReq.text}");
        // Check for salary range if provided
        if (minSalary.text.isNotEmpty && maxSalary.text.isNotEmpty) {
          double minSalaryValue = double.parse(minSalary.text);
          double maxSalaryValue = double.parse(maxSalary.text);
          // print("Salary 1: ${job.minSalary >= minSalaryValue}");
          // print("Salary 2: ${job.maxSalary <= maxSalaryValue}");
          if (job.minSalary >= minSalaryValue &&
              job.maxSalary <= maxSalaryValue) {
            filteredJobs.add(job);
            final resp = await RecruiterApi.getRecruiterWithCompanyDetails(
                job.recruiterId);
            filteredCompanies.add(Company.fromJson(resp['company_id']));
          }
        } else {
          filteredJobs.add(job);
          final resp = await RecruiterApi.getRecruiterWithCompanyDetails(
              job.recruiterId);
          filteredCompanies.add(Company.fromJson(resp['company_id']));
        }
      }
    }
    // print(filteredJobs.length);
    // Update the searched jobs and company list with filtered results

    if (filteredJobs.isEmpty) {
      isFilterResultEmpty.value = true;
      controller.jobList.clear();
      return;
    }
    _searchedJobs.value = filteredJobs;
    companyList.assignAll(filteredCompanies);
  }
}
