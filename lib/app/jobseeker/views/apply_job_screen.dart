import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../core/exports/constants_exports.dart';
import '../controllers/apply_job_controller.dart';

class ApplyJobScreen extends StatelessWidget {
  ApplyJobScreen({super.key, required this.jobId, required this.jobJsonUrl});

  final ApplyJobController applyController = Get.put(ApplyJobController());
  final String jobId;
  final String jobJsonUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: LightTheme.white),
          backgroundColor: LightTheme.primaryColor,
          title: const Txt(
            textAlign: TextAlign.start,
            title: "Apply For Job",
            fontContainerWidth: double.infinity,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontSize: Sizes.TEXT_SIZE_18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: Sizes.MARGIN_12,
              vertical: Sizes.MARGIN_12,
            ),
            child: Obx(
              () {
                if (applyController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LightTheme.primaryColor,
                    ),
                  );
                } else {
                  return Form(
                    key: applyController.applyFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: applyController.nameController,
                          labelText: 'Name',
                          prefixIconData: Icons.person,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name cannot be empty.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Sizes.SIZE_12),
                        CustomTextFormField(
                          controller: applyController.phoneController,
                          labelText: 'Contact Number',
                          keyboardType: TextInputType.phone,
                          prefixIconData: Icons.call,
                          readOnly: true,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Contact number cannot be empty.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Sizes.SIZE_12),
                        CustomTextFormField(
                          controller: applyController.emailController,
                          labelText: 'Email',
                          prefixIconData: Icons.email,
                          readOnly: true,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email cannot be empty.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Sizes.SIZE_16),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  applyController.pickDocument();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.MARGIN_12,
                                    vertical: Sizes.MARGIN_12,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: LightTheme.primaryColor,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  height: 80,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Txt(
                                          textAlign: TextAlign.start,
                                          title: "Upload your latest CV",
                                          fontContainerWidth: double.infinity,
                                          textStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: LightTheme.black,
                                            fontSize: Sizes.TEXT_SIZE_16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.upload,
                                        color: LightTheme.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Obx(() => applyController.pickedCV != null
                                ? const Icon(Icons.check_box,
                                    color: Colors.green, size: 30)
                                : const Icon(Icons.dangerous,
                                    color: Colors.red, size: 30)),
                          ],
                        ),
                        const SizedBox(height: Sizes.HEIGHT_14),
                        CustomButton(
                          buttonType: ButtonType.loading,
                          isLoading: applyController.isButtonLoading.value,
                          color: LightTheme.primaryColor,
                          loadingWidget: applyController.isButtonLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: LightTheme.primaryColor,
                                  ),
                                )
                              : null,
                          onPressed: () {
                            // applyController.applyForJob(jobId, jobJsonUrl);
                            applyController.applyForJob(jobId, '');
                          },
                          text: "Apply",
                          hasInfiniteWidth: true,
                          textColor: LightTheme.whiteShade2,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
