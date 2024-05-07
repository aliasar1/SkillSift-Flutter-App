import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/case_study_session_model.dart';
import '../../../core/services/case_study_session_api.dart';

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
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveProgress(
      String applicationId, String question, String res) async {
    try {
      isLoading.value = true;
      await CaseStudySessionService.saveProgress(applicationId, question, res);
      clearFields();
      Get.back();
    } catch (e) {
      print(e.toString());
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
