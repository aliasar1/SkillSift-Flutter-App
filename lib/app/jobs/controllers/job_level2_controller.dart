import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/services/level2_api.dart';

import '../../../core/helpers/quiz_summary_generator.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/models/quiz_summary_model.dart';
import '../../../core/services/application_api.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/quiz_summary_api.dart';
import '../../quiz/components/summary_view.dart';

class JobLevel2Controller extends GetxController {
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

      for (var element in applicationsResponse) {
        var status = false;
        if (element.currentLevel == "2" &&
            element.applicationStatus == "pending") {
          status = await Level2Api.checkIfApplicationIdExists(element.id!);
        }
        if (((element.currentLevel == "2" &&
                    element.applicationStatus == "pending") &&
                status) ||
            (element.currentLevel == "2" &&
                element.applicationStatus == "rejected") ||
            (element.currentLevel == '3' &&
                element.applicationStatus == "pending") ||
            (element.currentLevel == '3' &&
                element.applicationStatus == "accepted") ||
            (element.currentLevel == '3' &&
                element.applicationStatus == "rejected")) {
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

  List<QuizSummary> quizSummaries = [];
  Future<void> loadQuizSummary(String applicationId) async {
    try {
      quizSummaries =
          await QuizSummaryApi.getQuizSummariesByApplicationId(applicationId);
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> generateQuizSummaryPdf() async {
    final file = await PdfGenerator.generateQuizSummaryPdf(quizSummaries);
    Get.to(QuizSummaryView(
      file: file,
    ));
  }

  Future<Application?> findApplicationById(String appId) async {
    try {
      final resp = await ApplicationApi.findApplicationById(appId);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateJobStatus(
      String applicationId, String status, String level) async {
    try {
      final resp = await ApplicationApi.updateApplicationStatusAndLevel(
          applicationId, status, level);
      print(resp['application']);
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
}
