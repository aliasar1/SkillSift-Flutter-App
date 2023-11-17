import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/components/add_recruiter_screen.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/exports/constants_exports.dart';
import '../components/recruiter_card.dart';
import '../controllers/recruiter_controller.dart';

class RecruiterScreen extends StatelessWidget {
  RecruiterScreen({super.key});

  final recruiterController = Get.put(RecruiterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.primaryColor,
          iconTheme: const IconThemeData(color: LightTheme.white),
          title: const Txt(
            title: "Manage Recruiters",
            fontContainerWidth: double.infinity,
            textAlign: TextAlign.start,
            textStyle: TextStyle(
              fontFamily: "Poppins",
              color: LightTheme.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Obx(() {
          if (recruiterController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: LightTheme.primaryColor,
              ),
            );
          } else if (recruiterController.recruiters.isEmpty) {
            return const Center(
              child: Text('No recruiters found'),
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(
                vertical: Sizes.MARGIN_12,
                horizontal: Sizes.MARGIN_8,
              ),
              child: ListView.builder(
                itemCount: recruiterController.recruiters.length,
                itemBuilder: (context, index) {
                  final recruiter = recruiterController.recruiters[index];
                  return RecruiterCard(
                    recruiter: recruiter,
                    controller: recruiterController,
                  );
                },
              ),
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddRecruiterScreen(
              isEdit: false,
            ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.person_add,
            color: LightTheme.white,
          ),
        ),
      ),
    );
  }
}
