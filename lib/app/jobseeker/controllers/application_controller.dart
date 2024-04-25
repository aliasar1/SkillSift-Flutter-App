import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/application_model.dart';
import 'package:skillsift_flutter_app/core/services/application_api.dart';

class ApplicationController extends GetxController with CacheManager {
  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  RxList<Application> jobseekerApplications = <Application>[].obs;

  @override
  void onInit() {
    super.onInit();
    getApplicationsOfJobSeeker();
  }

  Future<void> getApplicationsOfJobSeeker() async {
    try {
      toggleLoading();
      final jobseekerId = getId();
      final applications =
          await ApplicationApi.getApplicationsByJobSeeker(jobseekerId!);
      jobseekerApplications.assignAll(applications);
    } catch (e) {
      Get.snackbar(
        'Error!',
        e.toString(),
      );
    } finally {
      toggleLoading();
    }
  }
}
