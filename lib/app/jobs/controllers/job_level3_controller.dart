import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skillsift_flutter_app/core/services/case_study_session_api.dart';

import '../../../core/models/application_model.dart';
import '../../../core/models/interview_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/services/application_api.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/fcm_api.dart';
import '../../../core/services/interview_api.dart';
import '../../../core/services/job_api.dart';

class JobLevel3Controller extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<bool> isSchedulerLoading = false.obs;
  RxBool isSortApplied = false.obs;
  RxBool isScheduled = false.obs;
  RxInt initialCount = 1.obs;

  final deadlineController = TextEditingController();
  final timeController = TextEditingController();
  DateTime? deadline;
  TimeOfDay? timeInterview;

  Future<void> scheduleInterview(
      String appId, DateTime date, TimeOfDay time) async {
    isSchedulerLoading.value = true;
    try {
      final formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      final interview = InterviewSchedule(
        applicationId: appId,
        date: date,
        time: formattedTime,
      );

      final success = await InterviewApi.scheduleInterview(interview);
      if (success) {
        isScheduled.value = true;
        deadlineController.text = DateFormat('dd-MM-yyyy').format(date);
        timeController.text = formattedTime;
        Get.snackbar('Success', 'Interview scheduled successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to schedule interview');
    } finally {
      isSchedulerLoading.value = false;
    }
  }

  Future<void> checkInterviewExists(String appId) async {
    isSchedulerLoading.value = true;
    try {
      final data = await InterviewApi.checkInterviewExists(appId);
      if (data['exists'] == true) {
        isScheduled.value = true;
        final interview = InterviewSchedule.fromJson(data['interview']);
        deadline = interview.date;
        deadlineController.text =
            DateFormat('dd-MM-yyyy').format(interview.date);
        timeController.text = interview.time;
        Get.snackbar('Notice', 'Interview already scheduled');
      } else {
        isScheduled.value = false;
        Get.snackbar('Notice', 'No interview found for this application');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to check interview: $e');
    } finally {
      isSchedulerLoading.value = false;
    }
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleSchedulerLoading() {
    isSchedulerLoading.value = !isSchedulerLoading.value;
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
      String applicationId, String status, String level, String jobId) async {
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
      final respJob = await JobApi.getJobById(jobId);
      Job job = Job.fromJson(respJob);
      final response = await AuthApi.getCurrentUser(
          false, applications[applicationToUpdateIndex].jobseekerId);
      final jobseeker = JobSeeker.fromJson(response);
      final tokens =
          await FCMNotificationsApi.getAllTokensOfUser(jobseeker.userId);
      if (tokens != null) {
        await FCMNotificationsApi.sendNotificationToAllTokens(
          tokens,
          'Congratulation!',
          'You are selected for interview round for ${job.title} job.',
        );
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
