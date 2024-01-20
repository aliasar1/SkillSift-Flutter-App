import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/bookmark/controllers/bookmark_controller.dart';
import 'package:skillsift_flutter_app/core/exports/widgets_export.dart';
import 'package:skillsift_flutter_app/core/models/job_model.dart';

import '../../../core/constants/firebase.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/constants/theme/light_theme.dart';
import '../../../core/widgets/job_card.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});

  final BookmarkController bmController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.MARGIN_12,
          vertical: Sizes.MARGIN_12,
        ),
        child: Column(
          children: [
            const Txt(
              textAlign: TextAlign.start,
              title: "My Bookmarks",
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Sizes.SIZE_12),
            StreamBuilder<List<Job>>(
              stream: bmController
                  .fetchBookmarkJobs(firebaseAuth.currentUser!.uid)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final bookmarkJobs = snapshot.data!;
                  if (bookmarkJobs.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bookmarkJobs.length,
                        itemBuilder: (context, index) {
                          final job = bmController.allJobList[index];
                          final company = bmController.allComapnyList[index];
                          return JobCard(
                            job: job,
                            company: company,
                            isFav: true,
                            bookmarkController: bmController,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Column(
                      children: [
                        SizedBox(height: Sizes.SIZE_24 * 3),
                        Center(child: Text('No jobs')),
                        // NoFavsTemplate(),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: LightTheme.primaryColor,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
