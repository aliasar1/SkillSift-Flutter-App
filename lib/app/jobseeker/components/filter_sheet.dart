import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';

Future<dynamic> createFilterSheet(BuildContext context) {
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

  double minSalary = 0;
  double maxSalary = 100;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: Get.height * 0.8,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: LightTheme.whiteShade2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Txt(
                title: "Advanced Filter Search",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Txt(
                title: "Find jobs based on your preferences.",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
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
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                icon: Icons.timeline_sharp,
                selectedValue: expSelected,
                items: expList,
                title: 'Experience Required',
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                icon: Icons.mode_comment,
                selectedValue: selectedMode,
                items: modeList,
                title: 'Job Mode',
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                icon: Icons.badge,
                selectedValue: selectedType,
                items: typeList,
                title: 'Job Type',
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDropdown(
                icon: Icons.factory,
                selectedValue: selectedIndustry,
                items: sectorList,
                title: 'Company Industry',
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 10),
              const Txt(
                title: "Salary Range",
                textAlign: TextAlign.start,
                fontContainerWidth: double.infinity,
                textStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              RangeSlider(
                values: RangeValues(minSalary, maxSalary),
                min: 0,
                max: 300,
                onChanged: (RangeValues values) {
                  // Implement logic to handle salary range selection
                },
                labels: RangeLabels(
                  '${minSalary.toStringAsFixed(0)}K',
                  '${maxSalary.toStringAsFixed(0)}K',
                ),
                divisions: 100,
              ),
              CustomButton(
                color: LightTheme.primaryColor,
                hasInfiniteWidth: true,
                // isLoading: controller.isLoading.value,
                // buttonType: ButtonType.loading,
                // loadingWidget: controller.isLoading.value
                //     ? const Center(
                //         child: CircularProgressIndicator(
                //           color: Colors.white,
                //           backgroundColor: LightTheme.primaryColor,
                //         ),
                //       )
                //     : null,
                onPressed: () async {
                  // await controller.resetPassword(
                  //     token, controller.passController.text.trim());
                },
                text: "Apply Filter",
                constraints: const BoxConstraints(maxHeight: 45, minHeight: 45),
                buttonPadding: const EdgeInsets.all(0),
                customTextStyle: const TextStyle(
                    fontSize: Sizes.TEXT_SIZE_12,
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal),
                textColor: LightTheme.white,
              ),
              // Obx(
              //   () => CustomButton(
              //     color: LightTheme.primaryColor,
              //     hasInfiniteWidth: true,
              //     isLoading: controller.isLoading.value,
              //     buttonType: ButtonType.loading,
              //     loadingWidget: controller.isLoading.value
              //         ? const Center(
              //             child: CircularProgressIndicator(
              //               color: Colors.white,
              //               backgroundColor: LightTheme.primaryColor,
              //             ),
              //           )
              //         : null,
              //     onPressed: () async {
              //       await controller.resetPassword(
              //           token, controller.passController.text.trim());
              //     },
              //     text: "Reset",
              //     constraints:
              //         const BoxConstraints(maxHeight: 45, minHeight: 45),
              //     buttonPadding: const EdgeInsets.all(0),
              //     customTextStyle: const TextStyle(
              //         fontSize: Sizes.TEXT_SIZE_12,
              //         color: Colors.white,
              //         fontFamily: "Poppins",
              //         fontWeight: FontWeight.normal),
              //     textColor: LightTheme.white,
              //   ),
              // ),
            ],
          ),
        ),
      );
    },
  );
}
