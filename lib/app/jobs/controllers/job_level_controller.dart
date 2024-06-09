import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/jobseeker_model.dart';

import '../../../core/models/application_model.dart';
import '../../../core/services/application_api.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/fcm_api.dart';

class JobLevelController extends GetxController {
  Rx<bool> isLoading = false.obs;
  RxInt initialCount = 1.obs;
  RxBool isSortApplied = false.obs;

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

      applications.assignAll(applicationsResponse);

      jobSeekers.clear();
      for (var application in applicationsResponse) {
        final response =
            await AuthApi.getCurrentUser(false, application.jobseekerId);
        final jobSeekerData = JobSeeker.fromJson(response);
        jobSeekers.add(jobSeekerData);
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

  Future<void> updateJobStatus(String applicationId, String status,
      String level, String jobseekerId, String jobTitle) async {
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
      final response = await AuthApi.getCurrentUser(false, jobseekerId);
      final jobseeker = JobSeeker.fromJson(response);
      final tokens =
          await FCMNotificationsApi.getAllTokensOfUser(jobseeker.userId);
      if (tokens != null) {
        await FCMNotificationsApi.sendNotificationToAllTokens(
          tokens,
          'Application Status Updated - Level 1',
          'Your application status is updated for $jobTitle.',
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
