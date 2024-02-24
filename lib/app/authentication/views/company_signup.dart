import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../components/company_signup_form.dart';
import '../controllers/auth_controller.dart';
import '../controllers/stepper_controller.dart';

class CompanySignupScreen extends StatefulWidget {
  const CompanySignupScreen({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  State<CompanySignupScreen> createState() => _CompanySignupScreenState();
}

class _CompanySignupScreenState extends State<CompanySignupScreen> {
  final authController = Get.put(AuthController());
  final stepperController = Get.put(StepperController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: true,
        onPopInvoked: (_) {
          authController.signupCompanyFormKey.currentState?.reset();
          authController.clearFields();
        },
        child: Scaffold(
          backgroundColor: LightTheme.whiteShade2,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: LightTheme.whiteShade2),
            backgroundColor: LightTheme.primaryColor,
            title: const Txt(
              title: "Complete Verification",
              fontContainerWidth: double.infinity,
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: LightTheme.whiteShade2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // Image.asset(
                    //   AppAssets.APP_ICON,
                    //   height: Sizes.ICON_SIZE_50 * 1.6,
                    //   width: Sizes.ICON_SIZE_50 * 3,
                    // ),
                    // Image.asset(
                    //   AppAssets.APP_TEXT,
                    //   height: Sizes.ICON_SIZE_50 * 1.7,
                    //   width: Sizes.ICON_SIZE_50 * 4,
                    // ),
                    const Txt(
                      title: "Complete Registration to Verify",
                      fontContainerWidth: double.infinity,
                      textAlign: TextAlign.start,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.secondaryColor,
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Txt(
                      title:
                          "Register your company information to unlock full app features.",
                      fontContainerWidth: double.infinity,
                      textAlign: TextAlign.start,
                      textStyle: TextStyle(
                        fontFamily: "Poppins",
                        color: LightTheme.secondaryColor,
                        fontSize: Sizes.TEXT_SIZE_14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    CompanySignupForm(
                        recruiter: widget.recruiter,
                        authController: authController,
                        stepperController: stepperController),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
