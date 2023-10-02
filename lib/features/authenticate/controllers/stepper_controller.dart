import 'package:get/get.dart';

class StepperController extends GetxController {
  RxInt _currentStep = 0.obs;

  int get getCurrentStep => _currentStep.value;

  void setCurrentStep(int step) {
    _currentStep.value = step;
  }

  void incrementCurrentStep() {
    _currentStep++;
  }

  void decreamentCurrentStep() {
    _currentStep--;
  }
}
