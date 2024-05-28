import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/services/case_study_session_api.dart';

import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/services/application_api.dart';
import '../../../core/services/auth_api.dart';

class JobLevel3Controller extends GetxController {
  Rx<bool> isLoading = false.obs;
  RxBool isSortApplied = false.obs;
  RxInt initialCount = 1.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleSort() {
    isSortApplied.value = !isSortApplied.value;
  }

  RxList<Application> applications = <Application>[].obs;
  RxList<JobSeeker> jobSeekers = <JobSeeker>[].obs;

  Future<void> getApplications(String jobId) async {
    try {
      isLoading.value = true;
      final applicationsResponse =
          await ApplicationApi.findApplicationsByJobId(jobId);

      for (var element in applicationsResponse) {
        num score = 0;
        if (element.currentLevel == "3" &&
            element.applicationStatus == "pending") {
          var data = await CaseStudySessionService.getScoreByApplicationId(
              element.id!);
          score = data.score!;
        }
        if (((element.currentLevel == "3" &&
                    element.applicationStatus == "pending") &&
                score != 0) ||
            (element.currentLevel == "3" &&
                element.applicationStatus == "rejected") ||
            (element.currentLevel == '3' &&
                element.applicationStatus == "accepted")) {
          applications.add(element);
        }
      }
      for (var application in applications) {
        final response =
            await AuthApi.getCurrentUser(false, application.jobseekerId);
        final jobSeekerData = JobSeeker.fromJson(response);
        jobSeekers.add(jobSeekerData);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateJobStatus(
      String applicationId, String status, String level) async {
    try {
      final resp = await ApplicationApi.updateApplicationStatusAndLevel(
          applicationId, status, level);

      Application updatedApplication =
          Application.fromJson(resp['application']);

      final applicationToUpdateIndex = applications.indexWhere(
        (application) => application.id == applicationId,
      );

      if (applicationToUpdateIndex != -1) {
        applications[applicationToUpdateIndex] = updatedApplication;

        applications.refresh();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Application?> findApplicationById(String appId) async {
    try {
      final resp = await ApplicationApi.findApplicationById(appId);
      return resp;
    } catch (e) {
      return null;
    }
  }
}
