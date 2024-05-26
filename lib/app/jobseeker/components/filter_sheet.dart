import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/jobseeker/controllers/all_jobs_controller.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../controllers/all_jobs_search_controller.dart';

Future<dynamic> createFilterSheet(BuildContext context,
    AllJobsSearchController searchController, AllJobsController controller) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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

  final qualificationList = [
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

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: Get.height * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isDarkMode ? DarkTheme.containerColor : LightTheme.whiteShade2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Txt(
                title: "Advanced Filter Search",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Txt(
                title: "Find jobs based on your preferences.",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 2,
                thickness: 2,
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                icon: Icons.school,
                selectedValue: selectedQualification,
                items: qualificationList,
                title: 'Qualification Required',
                onChanged: (value) {
                  selectedQualification = value!;
                  searchController.qualificationRequiredController.text =
                      selectedQualification;
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
                  expSelected = value!;
                  searchController.experienceReq.text = expSelected;
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
                  selectedMode = value!;
                  searchController.modeController.text = selectedMode;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                icon: Icons.badge,
                selectedValue: selectedType,
                items: typeList,
                title: 'Job Type',
                onChanged: (value) {
                  selectedMode = selectedType;
                  searchController.jobType.text = selectedType;
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
                  selectedMode = selectedIndustry;
                  searchController.jobIndustryController.text =
                      selectedIndustry;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 10),
              Txt(
                title: "Salary Range",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color:
                      isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Obx(
                () => RangeSlider(
                  activeColor: LightTheme.primaryColor,
                  inactiveColor: isDarkMode
                      ? DarkTheme.cardBackgroundColor
                      : LightTheme.greyShade8,
                  values: RangeValues(
                    searchController.min.value
                        .clamp(0.0, searchController.max.value),
                    searchController.max.value
                        .clamp(searchController.min.value, 300.0),
                  ),
                  min: 0,
                  max: 300,
                  onChanged: (RangeValues values) {
                    searchController.min.value = values.start;
                    searchController.max.value = values.end;
                  },
                  labels: RangeLabels(
                    '${searchController.min.value.toStringAsFixed(0)}K',
                    '${searchController.max.value.toStringAsFixed(0)}K',
                  ),
                  divisions: 100,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      onPressed: () async {
                        await searchController.applyFilter(controller);
                        Get.back();
                      },
                      text: "Apply Filters",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_14,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomButton(
                      color: LightTheme.primaryColor,
                      hasInfiniteWidth: true,
                      buttonType: ButtonType.outline,
                      onPressed: () async {
                        Get.back();
                        await searchController.clearFilters(controller);
                      },
                      text: "Clear Filters",
                      constraints:
                          const BoxConstraints(maxHeight: 45, minHeight: 45),
                      buttonPadding: const EdgeInsets.all(0),
                      customTextStyle: const TextStyle(
                          fontSize: Sizes.TEXT_SIZE_14,
                          fontFamily: "Poppins",
                          color: LightTheme.primaryColor,
                          fontWeight: FontWeight.normal),
                      textColor: LightTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
