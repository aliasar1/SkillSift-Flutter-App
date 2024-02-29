// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../../../core/exports/constants_exports.dart';
// import '../../../../core/exports/widgets_export.dart';
// import '../../../../core/widgets/recruiter_drawer.dart';
// import '../../../../core/widgets/templates/no_jobs_added.dart';
// import '../../../authentication/controllers/auth_controller.dart';
// import '../components/add_jobs_screen.dart';
// import '../controllers/job_search_controller.dart';
// import '../controllers/jobs_controller.dart';

// class RecruiterDashboard extends StatefulWidget {
//   RecruiterDashboard({super.key});

//   @override
//   State<RecruiterDashboard> createState() => _RecruiterDashboardState();
// }

// class _RecruiterDashboardState extends State<RecruiterDashboard> {
//   final authController = Get.put(AuthController());
//   // final profileController = Get.put(RecruiterProfileController());
//   final jobController = Get.put(JobController());
//   final JobSearchController searchController = Get.put(JobSearchController());

//   @override
//   void dispose() {
//     Get.delete<JobSearchController>();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: LightTheme.whiteShade2,
//         // drawer: RecruiterDrawer(
//         //   authController: authController,
//         //   // profileController: profileController,
//         // ),
//         appBar: AppBar(),
//         body: Column(
//           children: [
//             Column(children: [
//               Column(
//                 children: [
//                   Container(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
//                     child: Column(
//                       children: [
//                         Txt(
//                           textAlign: TextAlign.start,
//                           title: 'Hello!',
//                           // title:
//                           //     'Hello ${profileController.user['fullName']}!',
//                           fontContainerWidth: double.infinity,
//                           textStyle: const TextStyle(
//                             fontFamily: "Poppins",
//                             color: LightTheme.secondaryColor,
//                             fontSize: Sizes.TEXT_SIZE_22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: Sizes.HEIGHT_10),
//                         const Txt(
//                           textAlign: TextAlign.start,
//                           title: "Welcome To Recruiter Dashboard",
//                           fontContainerWidth: double.infinity,
//                           textStyle: TextStyle(
//                             fontFamily: "Poppins",
//                             color: LightTheme.primaryColor,
//                             fontSize: Sizes.TEXT_SIZE_16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: Sizes.HEIGHT_18),
//                         CustomSearchWidget(
//                           label: 'Search added jobs here...',
//                           onFieldSubmit: (val) {
//                             searchController.searchJob(val, jobController);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               // Obx(
//               //   () {
//               //     // if (profileController.isLoading.value) {
//               //     //   return const Center(
//               //     //     child: CircularProgressIndicator(
//               //     //       color: LightTheme.whiteShade2,
//               //     //     ),
//               //     //   );
//               //     // } else {
//               // return Column(
//               //   children: [
//               //     Container(
//               //       margin: const EdgeInsets.symmetric(
//               //           horizontal: Sizes.MARGIN_16),
//               //       child: Column(
//               //         children: [
//               //           Txt(
//               //             textAlign: TextAlign.start,
//               //             title:
//               //                 'Hello!',
//               //             // title:
//               //             //     'Hello ${profileController.user['fullName']}!',
//               //             fontContainerWidth: double.infinity,
//               //             textStyle: const TextStyle(
//               //               fontFamily: "Poppins",
//               //               color: LightTheme.secondaryColor,
//               //               fontSize: Sizes.TEXT_SIZE_22,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //           const SizedBox(height: Sizes.HEIGHT_10),
//               //           const Txt(
//               //             textAlign: TextAlign.start,
//               //             title: "Welcome To Recruiter Dashboard",
//               //             fontContainerWidth: double.infinity,
//               //             textStyle: TextStyle(
//               //               fontFamily: "Poppins",
//               //               color: LightTheme.primaryColor,
//               //               fontSize: Sizes.TEXT_SIZE_16,
//               //               fontWeight: FontWeight.bold,
//               //             ),
//               //           ),
//               //           const SizedBox(height: Sizes.HEIGHT_18),
//               //           CustomSearchWidget(
//               //             label: 'Search added jobs here...',
//               //             onFieldSubmit: (val) {
//               //               searchController.searchJob(
//               //                   val, jobController);
//               //             },
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ],
//               // );
//               //     }
//               //   },
//               // ),
//             ]),
//             Obx(() {
//               if (jobController.isLoading.value) {
//                 return const Expanded(
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: LightTheme.primaryColor,
//                     ),
//                   ),
//                 );
//               } else if (jobController.jobList.isEmpty) {
//                 return NoJobsAddedTemplate();
//               } else if (searchController.searchedJobs.isNotEmpty) {
//                 return Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: Sizes.MARGIN_16),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: Sizes.HEIGHT_16),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: searchController.searchedJobs.length,
//                             itemBuilder: (context, index) {
//                               final job = searchController.searchedJobs[index];
//                               final company =
//                                   searchController.searchJobCompany[index];
//                               if (job.jobAddedBy ==
//                                   firebaseAuth.currentUser!.uid) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 14),
//                                   child: ListTile(
//                                     onTap: () {
//                                       // Get.to(JobDetailsScreen(
//                                       //     company: company,
//                                       //     job: job,
//                                       //     isCompany: true));
//                                     },
//                                     tileColor: LightTheme.greyShade1,
//                                     leading: IconButton(
//                                         onPressed: () {
//                                           jobController.deleteJob(
//                                               job.jobId, index);
//                                         },
//                                         icon: const Icon(Icons.delete)),
//                                     title: Text(job.jobTitle),
//                                     subtitle: Text(job.mode),
//                                     trailing: IconButton(
//                                         onPressed: () {
//                                           Get.to(AddJobScreen(
//                                             isEdit: true,
//                                             job: job,
//                                             jobController: jobController,
//                                           ));
//                                         },
//                                         icon: const Icon(Icons.edit)),
//                                   ),
//                                 );
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: Sizes.MARGIN_16),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: Sizes.HEIGHT_16),
//                           ListView.builder(
//                             itemCount: jobController.jobList.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               final job = jobController.jobList[index];
//                               final company =
//                                   jobController.allCompanyList[index];
//                               if (job.jobAddedBy ==
//                                   firebaseAuth.currentUser!.uid) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 14),
//                                   child: ListTile(
//                                     onTap: () {
//                                       // Get.to(JobDetailsScreen(
//                                       //     company: company,
//                                       //     job: job,
//                                       //     isCompany: true));
//                                     },
//                                     tileColor: LightTheme.greyShade1,
//                                     leading: IconButton(
//                                         onPressed: () {
//                                           jobController.deleteJob(
//                                               job.jobId, index);
//                                         },
//                                         icon: const Icon(Icons.delete)),
//                                     title: Text(job.jobTitle),
//                                     subtitle: Text(job.mode),
//                                     trailing: IconButton(
//                                         onPressed: () {
//                                           Get.to(AddJobScreen(
//                                             isEdit: true,
//                                             job: job,
//                                             jobController: jobController,
//                                           ));
//                                         },
//                                         icon: const Icon(Icons.edit)),
//                                   ),
//                                 );
//                               } else {
//                                 return const SizedBox.shrink();
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             }),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             jobController.clearFields();
//             Get.to(AddJobScreen(
//               isEdit: false,
//               jobController: jobController,
//             ));
//           },
//           backgroundColor: LightTheme.primaryColor,
//           child: const Icon(
//             Icons.post_add,
//             color: LightTheme.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
