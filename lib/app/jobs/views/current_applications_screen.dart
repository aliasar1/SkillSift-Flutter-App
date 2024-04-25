import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';
import 'package:skillsift_flutter_app/core/services/application_api.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/models/application_model.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/widgets/custom_text.dart';
import '../../jobseeker/controllers/application_controller.dart';
import 'applicant_details_screen.dart';

class CurrentApplicationScreen extends StatefulWidget {
  const CurrentApplicationScreen({super.key, required this.jobId});

  final String jobId;

  @override
  State<CurrentApplicationScreen> createState() =>
      _CurrentApplicationScreenState();
}

class _CurrentApplicationScreenState extends State<CurrentApplicationScreen> {
  List<JobSeeker>? jobSeekers;
  List<Application>? applications;
  bool isLoading = true;

  final applicationController = Get.put(ApplicationController());

  @override
  void initState() {
    super.initState();
    getApplications();
  }

  Future<void> getApplications() async {
    try {
      final applicationsResponse =
          await ApplicationApi.findApplicationsByJobId(widget.jobId);
      applications = applicationsResponse;

      jobSeekers = [];
      for (var application in applicationsResponse) {
        final response =
            await AuthApi.getCurrentUser(false, application.jobseekerId);
        final jobSeekerData = JobSeeker.fromJson(response);
        jobSeekers!.add(jobSeekerData);
      }
      setState(() {});
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Applications",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      title: Container(
                        height: 10,
                        color: Colors.white,
                      ),
                      subtitle: Container(
                        height: 10,
                        color: Colors.white,
                      ),
                      trailing: Container(
                        width: 50,
                        height: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            )
          : ListView.builder(
              itemCount: applications!.length,
              itemBuilder: (context, index) {
                final jobseeker = jobSeekers![index];
                final application = applications![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ApplicantDetailsScreen(
                        jobseeker: jobseeker,
                        application: application,
                      ));
                    },
                    child: ListTile(
                      tileColor: LightTheme.cardLightShade,
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: SizedBox(
                        width: Get.width * 0.5,
                        child: Txt(
                          textAlign: TextAlign.start,
                          title: jobseeker.fullname,
                        ),
                      ),
                      subtitle: SizedBox(
                        width: Get.width * 0.5,
                        child: const Txt(
                          textAlign: TextAlign.start,
                          title: "CV Rating: ${22}%",
                        ),
                      ),
                      trailing: SizedBox(
                        width: Get.width * 0.25,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check_box,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
