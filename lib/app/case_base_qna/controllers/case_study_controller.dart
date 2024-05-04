import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/case_study_session_api.dart';

class CaseStudyController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt remainingTime = 0.obs;

  final studyAnsController = TextEditingController();

  Future<void> addStartTime(String applicationId) async {
    try {
      isLoading.value = true;
      await CaseStudySessionService.addStartTime(applicationId);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> calculateRemainingTime(String id) async {
    try {
      isLoading.value = true;
      final time = await CaseStudySessionService.calculateRemainingTime(id);
      if (time != null) {
        remainingTime.value = time;
      } else {
        // Session not found, handle accordingly
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
