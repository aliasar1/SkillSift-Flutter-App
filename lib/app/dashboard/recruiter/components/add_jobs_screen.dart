import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/recruiter/controllers/jobs_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/models/job_model.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key, required this.isEdit, this.job});

  final bool isEdit;
  final Job? job;

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  JobController jobController = Get.find<JobController>();

  @override
  void initState() {
    if (widget.isEdit) {
      final job = widget.job!;
      jobController.jobTitleController.text = job.jobTitle;
      jobController.jobDescriptionController.text = job.jobDescription;
      jobController.skillsRequiredController.value = job.skillsRequired;
      jobController.qualificationRequiredController.text =
          job.qualificationRequired;
      jobController.modeController.text = job.mode;
      selectedMode = job.mode;
      jobController.jobIndustryController.text = job.industry;
      selectedIndustry = job.industry;
      jobController.maxSalary.text = job.maxSalary;
      jobController.minSalary.text = job.minSalary;
    }
    super.initState();
  }

  final sectorList = [
    'Information Technology',
    'Healthcare Industry',
    'Finance Industry',
    'Manufacturing Industry'
  ];

  var selectedIndustry = 'Information Technology';

  final modeList = [
    'Onsite',
    'Remote',
    'Hybrid',
  ];

  var selectedMode = 'Onsite';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: LightTheme.white),
            onPressed: () {
              Get.back();
              jobController.clearFields();
            },
          ),
          title: Txt(
            title: widget.isEdit ? "Edit Job" : "Add Job",
            fontContainerWidth: double.infinity,
            textAlign: TextAlign.start,
            textStyle: const TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: Sizes.MARGIN_12,
            horizontal: Sizes.MARGIN_14,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: jobController.addJobsFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: jobController.jobTitleController,
                    labelText: 'Job Title',
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job title cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: jobController.jobDescriptionController,
                    labelText: 'Job Description',
                    autofocus: false,
                    maxLines: 5,
                    readOnly: widget.isEdit,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.numbers,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job description cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ChipTags(
                    list: jobController.skillsRequiredController,
                    chipColor: LightTheme.primaryColorLightShade,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    chipPosition: ChipPosition.below,
                    separator: " ",
                    createTagOnSubmit: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      labelText: 'Skill Tags',
                      hintText: 'Type Skill Tags and press space',
                      labelStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        color: LightTheme.black,
                        fontSize: Sizes.SIZE_16,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: const TextStyle(
                          color: LightTheme.black,
                          fontFamily: 'Poppins',
                          fontSize: Sizes.SIZE_16,
                          fontWeight: FontWeight.normal),
                      prefixIcon: const Icon(
                        Icons.tag,
                        size: 20,
                        color: LightTheme.primaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: LightTheme.primaryColorLightShade,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: LightTheme.primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: Sizes.SIZE_20,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: LightTheme.primaryColorLightShade, width: 1),
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_4),
                      ),
                      alignLabelWithHint: true,
                      focusColor: LightTheme.primaryColor,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: jobController.qualificationRequiredController,
                    labelText: 'Qualification Required',
                    autofocus: false,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Qualification required cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropdown(
                    icon: Icons.mode_comment,
                    selectedValue: selectedMode,
                    items: modeList,
                    title: 'Job Mode',
                    onChanged: (value) {
                      setState(() {
                        selectedMode = value!;
                        jobController.modeController.text = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropdown(
                    icon: Icons.factory,
                    selectedValue: selectedIndustry,
                    items: sectorList,
                    title: 'Company Industry',
                    onChanged: (value) {
                      setState(() {
                        selectedIndustry = value!;
                        jobController.jobIndustryController.text = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: jobController.minSalary,
                    labelText: 'Minimum Salary (in USD)',
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Min salary required cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: jobController.maxSalary,
                    labelText: 'Maximum Salary (in USD)',
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    prefixIconData: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Max salary required cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.loading,
                      isLoading: jobController.isLoading.value,
                      loadingWidget: jobController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: LightTheme.primaryColor,
                              ),
                            )
                          : null,
                      onPressed: () {
                        widget.isEdit
                            ? jobController.updateJob(
                                widget.job!.jobId,
                                jobController.jobTitleController.text,
                                jobController.jobDescriptionController.text,
                                jobController
                                    .qualificationRequiredController.text,
                                jobController.modeController.text,
                                jobController.jobIndustryController.text,
                                jobController.minSalary.text,
                                jobController.maxSalary.text)
                            : jobController.addJob(
                                jobController.jobTitleController.text,
                                jobController.jobDescriptionController.text,
                                jobController
                                    .qualificationRequiredController.text,
                                jobController.modeController.text,
                                jobController.jobIndustryController.text,
                                jobController.minSalary.text,
                                jobController.maxSalary.text);
                      },
                      text: widget.isEdit ? "Edit" : "Add",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_12,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
