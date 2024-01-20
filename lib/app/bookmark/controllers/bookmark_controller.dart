import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/job_model.dart';

import '../../../core/constants/firebase.dart';
import '../../../core/models/company_model.dart';

class BookmarkController extends GetxController {
  final RxList<Job> _bookmarkJobs = RxList<Job>([]);
  List<Job> get bookmarkJobs => _bookmarkJobs;

  Rx<bool> isLoading = false.obs;

  RxList<Job> allJobList = <Job>[].obs;
  RxList<Company> allComapnyList = <Company>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookmarkJobs(firebaseAuth.currentUser!.uid);
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> toggleBookmarkStatus(Job job) async {
    try {
      var userDocRef =
          firestore.collection('bookmarks').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var jobsIds = userDoc.data()?['jobsIds'] ?? [];

        if (jobsIds.contains(job.jobId)) {
          jobsIds.remove(job.jobId);
        } else {
          jobsIds.add(job.jobId);
        }

        await userDocRef.update({'jobsIds': jobsIds});
      } else {
        await userDocRef.set({
          'jobsIds': [job.jobId]
        });
        Get.snackbar('Success!', 'Job is bookmarked.');
      }

      fetchBookmarkJobs(firebaseAuth.currentUser!.uid);
    } catch (error) {
      Get.snackbar('Failure!', error.toString());
    }
  }

  Future<bool> getBookmarkStatus(String jobId) async {
    try {
      var userDocRef =
          firestore.collection('bookmarks').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var bookmarkData = userDoc.data();
        var jobsIds = bookmarkData?['jobsIds'] ?? [];

        return jobsIds.contains(jobId);
      } else {
        return false;
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return false;
    }
  }

  Future<Company> getCompanyData(String id) async {
    var snap = await firestore.collection('companies').doc(id).get();
    var companyData = Company.fromJson(snap.data()!);
    return companyData;
  }

  Future<List<Job>> fetchBookmarkJobs(String userId) async {
    try {
      toggleLoading();
      var userDocRef = firestore.collection('bookmarks').doc(userId);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var bookmarksData = userDoc.data();
        var bookmarkIds = bookmarksData!['jobsIds'] as List<dynamic>;
        var bookmarkJobs = <Job>[];

        allJobList.clear();
        allComapnyList.clear();

        for (var bookmarkId in bookmarkIds) {
          var snapshot = await firestore.collectionGroup('jobsAdded').get();

          for (QueryDocumentSnapshot doc in snapshot.docs) {
            String companyId = doc['companyId'];
            String jobId = doc.reference.id;

            if (bookmarkId == jobId) {
              Map<String, dynamic> jobData = doc.data() as Map<String, dynamic>;
              Job job = Job.fromMap(jobId, jobData);
              var companyData = await getCompanyData(companyId);

              allComapnyList.add(companyData);
              allJobList.add(job);
              bookmarkJobs.add(job);
              break;
            }
          }
        }
        isLoading.value = false;
        return bookmarkJobs;
      } else {
        isLoading.value = false;
        return [];
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failure!', error.toString());
      return [];
    }
  }
}
