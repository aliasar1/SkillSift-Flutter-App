import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/components/add_recruiter_screen.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/exports/constants_exports.dart';
import '../controllers/recruiter_controller.dart';

class RecruiterScreen extends StatelessWidget {
  RecruiterScreen({super.key});

  final recruiterController = Get.put(RecruiterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Container(),
        // body: Obx(() {
        // if (recruiterController.isLoading.value) {
        //   return const Expanded(
        //       child: CircularProgressIndicator(
        //     color: LightTheme.primaryColor,
        //   ));
        // } else if (recruiterController.recruiters.isEmpty) {
        //   return const Center(
        //     child: Text('No recruiters found'),
        //   );
        // } else {
        //   return Container(
        //     margin: const EdgeInsets.symmetric(
        //       vertical: Sizes.MARGIN_12,
        //       horizontal: Sizes.MARGIN_8,
        //     ),
        //     child: Column(
        //       children: [
        //         Expanded(
        //           child: ListView.builder(
        //               itemCount: 10,
        //               itemBuilder: (context, index) {
        //                 return const ListTile(
        //                   leading: Icon(Icons.person),
        //                   title: Txt(
        //                     title: "Ali Asar",
        //                     fontContainerWidth: double.infinity,
        //                     textAlign: TextAlign.start,
        //                     textStyle: TextStyle(
        //                       fontFamily: "Poppins",
        //                       color: LightTheme.black,
        //                       fontWeight: FontWeight.normal,
        //                     ),
        //                   ),
        //                   subtitle: Txt(
        //                     title: "Talent Recruiter",
        //                     fontContainerWidth: double.infinity,
        //                     textAlign: TextAlign.start,
        //                     textStyle: TextStyle(
        //                       fontFamily: "Poppins",
        //                       color: LightTheme.black,
        //                       fontWeight: FontWeight.normal,
        //                     ),
        //                   ),
        //                   trailing: Icon(
        //                     Icons.more_horiz,
        //                     color: LightTheme.primaryColor,
        //                   ),
        //                 );
        //               }),
        //         ),
        //       ],
        //     ),
        //   );
        // }
        // }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddRecruiterScreen());
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
