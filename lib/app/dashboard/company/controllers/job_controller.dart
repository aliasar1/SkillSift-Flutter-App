import 'package:get/get.dart';

class JobController extends GetxController {
  Rx<bool> isLoading = false.obs;
  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
