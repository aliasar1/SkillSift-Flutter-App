import 'package:flutter/material.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';
import '../../../core/models/recruiter_model.dart';

class RecruiterDashboard extends StatelessWidget {
  const RecruiterDashboard({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme.whiteShade2,
        appBar: AppBar(
          backgroundColor: LightTheme.whiteShade2,
        ),
        drawer: RecruiterDashboard(
          recruiter: recruiter,
        ),
        body: Column(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Sizes.MARGIN_16),
                      child: Column(
                        children: [
                          Txt(
                            textAlign: TextAlign.start,
                            title: 'Hello ${recruiter.fullname}! 👋',
                            fontContainerWidth: double.infinity,
                            textStyle: const TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.secondaryColor,
                              fontSize: Sizes.TEXT_SIZE_22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: Sizes.HEIGHT_10),
                          const Txt(
                            textAlign: TextAlign.start,
                            title: "Welcome To Recruiter Dashboard",
                            fontContainerWidth: double.infinity,
                            textStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: LightTheme.primaryColor,
                              fontSize: Sizes.TEXT_SIZE_16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: Sizes.HEIGHT_18),
                          CustomSearchWidget(
                            label: 'Search added jobs here...',
                            onFieldSubmit: (val) {
                              // searchController.searchJob(val, jobController);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // jobController.clearFields();
            // Get.to(AddJobScreen(
            //   isEdit: false,
            //   jobController: jobController,
            // ));
          },
          backgroundColor: LightTheme.primaryColor,
          child: const Icon(
            Icons.post_add,
            color: LightTheme.white,
          ),
        ),
      ),
    );
  }
}
