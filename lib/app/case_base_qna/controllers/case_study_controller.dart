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

  // Future<void> calculateRemainingTime(String id) async {
  //   try {
  //     isLoading.value = true;
  //     final Map<String, dynamic> result =
  //         await CaseStudySessionService.calculateRemainingTime(id);
  //     final Map<String, dynamic>? time = result['remainingTime'];
  //     final bool isSessionExist = result['isSessionExist'] ?? false;

  //     print(time);
  //     if (time != null) {
  //       final int hours = time['hours'] ~/ 3600;
  //       final int minutes = (time['minutes'] % 3600) ~/ 60;
  //       final int seconds = time['seconds'] % 60;

  //       remainingTime.value = {
  //         'hours': hours,
  //         'minutes': minutes,
  //         'seconds': seconds,
  //       };
  //       this.isSessionExist.value = isSessionExist;
  //     } else {
  //       this.isSessionExist.value = isSessionExist;
  //     }
  //   } catch (e) {
  //     print('Error calculating remaining time: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onClose() {
    studyAnsController.dispose();
    super.onClose();
  }
}
