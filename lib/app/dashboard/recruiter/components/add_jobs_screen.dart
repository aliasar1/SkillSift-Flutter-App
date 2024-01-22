import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/recruiter/controllers/jobs_controller.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/exports/widgets_export.dart';
import '../../../../core/models/job_model.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen(
      {super.key, required this.isEdit, this.job, required this.jobController});

  final bool isEdit;
  final Job? job;
  final JobController jobController;

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  late final JobController jobController;

  @override
  void initState() {
    jobController = widget.jobController;

    if (widget.isEdit) {
      final job = widget.job!;
      jobController.jobTitleController.text = job.jobTitle;
      jobController.jobDescriptionController.text = job.jobDescription;
      jobController.skillsRequiredController.value = job.skillsRequired;
      jobController.qualificationRequiredController.text =
          job.qualificationRequired;
      selectedQualification = job.qualificationRequired;
      jobController.modeController.text = job.mode;
      selectedMode = job.mode;
      jobController.jobIndustryController.text = job.industry;
      selectedIndustry = job.industry;
      jobController.maxSalary.text = job.maxSalary;
      jobController.minSalary.text = job.minSalary;
      jobController.jobType.text = job.jobType;
      selectedType = job.jobType;
      jobController.experienceReq.text = job.experienceReq;
      expSelected = job.experienceReq;
    } else {
      jobController.modeController.text = 'Onsite';
      jobController.jobIndustryController.text = 'Information Technology';
      jobController.jobType.text = 'Full Time';
      jobController.experienceReq.text = '0-1 Years';
      jobController.qualificationRequiredController.text = 'Undergraduate';
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

  final typeList = [
    'Full Time',
    'Part Time',
    'Contract Based',
  ];

  var selectedType = 'Full Time';

  final qulificationList = [
    'Undergraduate',
    'Graduate',
    'Masters',
    'PhD',
  ];

  var selectedQualification = 'Undergraduate';

  final expList = [
    '0-1 Years',
    '1-2 Years',
    '2-4 Years',
    '4+ Years',
  ];

  var expSelected = '0-1 Years';

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
                  CustomDropdown(
                    icon: Icons.school,
                    selectedValue: selectedQualification,
                    items: qulificationList,
                    title: 'Qualification Required',
                    onChanged: (value) {
                      setState(() {
                        selectedQualification = value!;
                        jobController.qualificationRequiredController.text =
                            value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDropdown(
                    icon: Icons.timeline_sharp,
                    selectedValue: expSelected,
                    items: expList,
                    title: 'Experience Required',
                    onChanged: (value) {
                      setState(() {
                        expSelected = value!;
                        jobController.experienceReq.text = value;
                      });
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
                    icon: Icons.badge,
                    selectedValue: selectedType,
                    items: typeList,
                    title: 'Job Tyoe',
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                        jobController.jobType.text = value;
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
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            jobController.pickDocument();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Txt(
                                    textAlign: TextAlign.start,
                                    title: "Upload your Job Description",
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
                      Obx(() => jobController.pickedJD != null
                          ? const Icon(Icons.check_box,
                              color: Colors.green, size: 30)
                          : const Icon(Icons.dangerous,
                              color: Colors.red, size: 30)),
                    ],
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
                                jobController.maxSalary.text,
                                jobController.jobType.text,
                                widget.job!.creationDateTime,
                                jobController.experienceReq.text,
                                widget.job!.jdUrl)
                            : jobController.addJob(
                                jobController.jobTitleController.text,
                                jobController.jobDescriptionController.text,
                                jobController
                                    .qualificationRequiredController.text,
                                jobController.modeController.text,
                                jobController.jobIndustryController.text,
                                jobController.minSalary.text,
                                jobController.maxSalary.text,
                                jobController.jobType.text,
                                jobController.experienceReq.text,
                                jobController.downloadUrl);
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
