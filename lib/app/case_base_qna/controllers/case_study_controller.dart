import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/case_study_session_api.dart';

class CaseStudyController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt remainingTime = 0.obs;

  final studyAnsController = TextEditingController();

  Future<void> addStartTime(String applicationId, String question) async {
    try {
      isLoading.value = true;
      await CaseStudySessionService.addStartTime(applicationId, question, "");
    } catch (e) {
      print('Error adding start time: $e');
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> calculateRemainingTime(String id) async {
    try {
      isLoading.value = true;
      final time = await CaseStudySessionService.calculateRemainingTime(id);
      print('Remaining time: $time');
      if (time != null) {
        remainingTime.value = time;
      } else {
        // Session not found, handle accordingly
      }
    } catch (e) {
      print('Error calculating remaining time: $e');
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    studyAnsController.dispose();
    super.onClose();
  }
}
