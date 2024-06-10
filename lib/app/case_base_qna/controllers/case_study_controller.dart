import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/case_study_session_model.dart';
import '../../../core/models/job_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/case_study_session_api.dart';
import '../../../core/services/fcm_api.dart';
import '../../../core/services/job_api.dart';

class CaseStudyController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSessionExist = false.obs;
  late CaseStudySession? session;

  RxInt hours = 0.obs;
  RxInt mins = 0.obs;
  RxInt secs = 0.obs;

  final studyAnsController = TextEditingController();

  void clearFields() {
    hours.value = 0;
    mins.value = 0;
    secs.value = 0;
    isLoading.value = false;
    isSessionExist.value = false;
    session = null;
    studyAnsController.clear();
  }

  Future<void> addStartTime(String applicationId, String question) async {
    try {
      isLoading.value = true;
      await CaseStudySessionService.addStartTime(applicationId, question, "");
    } catch (e) {
      print('Error adding start time: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getData(String id) async {
    try {
      final Map<String, dynamic> result =
          await CaseStudySessionService.getSessionData(id);
      print(result);
      if (result['isSessionExist']) {
        session = CaseStudySession.fromJson(result['data']);
        isSessionExist.value = true;
      } else {
        isSessionExist.value = false;
        session = null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveProgress(
      String applicationId, String question, String res, String status) async {
    try {
      isLoading.value = true;

      await CaseStudySessionService.saveProgress(
          applicationId, question, res, status);
    } catch (e) {
      print(e.toString());
    } finally {
      Get.back();
    }
  }

  Future<void> submitResponse(
    String applicationId,
    String question,
    String res,
    String status,
    double score,
    String jobseekerId,
    String jobId,
  ) async {
    try {
      isLoading.value = true;
      print(res);
      await CaseStudySessionService.submitResponse(
          applicationId, question, res, status, score);
      final respJob = await JobApi.getJobById(jobId);
      Job job = Job.fromJson(respJob);
      final response = await AuthApi.getCurrentUser(false, jobseekerId);
      final jobseeker = JobSeeker.fromJson(response);
      final r = await AuthApi.getCurrentUser(true, job.recruiterId);
      final recruiter = Recruiter.fromJson(r);
      print(recruiter.userId);
      final tokens =
          await FCMNotificationsApi.getAllTokensOfUser(recruiter.userId);
      print(tokens);
      if (tokens != null) {
        await FCMNotificationsApi.sendNotificationToAllTokens(
          tokens,
          'Case Study submitted for ${job.title}',
          '${jobseeker.fullname} has submitted Case Study for the ${job.title} job.',
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Get.back();
    }
  }

  @override
  void onClose() {
    studyAnsController.dispose();
    super.onClose();
  }
}
