import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/controllers/auth_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/controllers/stepper_controller.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/login_screen.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text_form_field.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_button.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class CompanySignupScreen extends StatelessWidget {
  CompanySignupScreen({super.key});

  final controller = Get.put(AuthController());
  final stepperController = Get.put(StepperController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Obx(
        () => Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: stepperController.getCurrentStep,
          onStepTapped: (step) {
            stepperController.setCurrentStep(step);
          },
          onStepContinue: () {
            final isLastStep =
                stepperController.getCurrentStep == getSteps().length - 1;
            if (isLastStep) {
              print("Done");
            } else {
              stepperController.incrementCurrentStep();
            }
          },
          onStepCancel: () {
            stepperController.getCurrentStep == 0
                ? null
                : stepperController.decreamentCurrentStep();
          },
        ),
      ),
    ));
  }

  List<Step> getSteps() => [
        Step(
          isActive: stepperController.getCurrentStep >= 0,
          state: stepperController.getCurrentStep > 0
              ? StepState.complete
              : StepState.indexed,
          title: Text("Details"),
          content: Container(),
        ),
        Step(
          isActive: stepperController.getCurrentStep >= 1,
          state: stepperController.getCurrentStep > 1
              ? StepState.complete
              : StepState.indexed,
          title: Text("Address"),
          content: Container(),
        ),
        Step(
          isActive: stepperController.getCurrentStep >= 2,
          state: stepperController.getCurrentStep > 2
              ? StepState.complete
              : StepState.indexed,
          title: Text("Verification"),
          content: Container(),
        ),
      ];
}
