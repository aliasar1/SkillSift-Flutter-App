import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/models/job_model.dart';
import 'package:skillsift_flutter_app/core/services/bookmark_api.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../core/services/job_api.dart';

class BookmarkController extends GetxController with CacheManager {
  final RxList<Job> _bookmarkJobs = RxList<Job>([]);
  List<Job> get bookmarkJobs => _bookmarkJobs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> isRendering = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
    getBookmarks();
  }

  Future<void> toggleBookmarkStatus(Job bmJob) async {
    if (_bookmarkJobs.any((job) => job.id == bmJob.id)) {
      await removeBookmark(getId()!, bmJob.id);
      _bookmarkJobs.removeWhere((job) => job.id == bmJob.id);
    } else {
      await addBookmark(bmJob.id);
      _bookmarkJobs.add(bmJob);
    }
  }

  Future<void> addBookmark(String jobId) async {
    try {
      toggleLoading();
      await BookmarkApi.addBookmark(
        jobseekerId: getId()!,
        jobId: jobId,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      toggleLoading();
    }
  }

  Future<void> removeBookmark(String jobseekerId, String jobId) async {
    try {
      toggleLoading();
      await BookmarkApi.removeBookmark(
        jobseekerId: jobseekerId,
        jobId: jobId,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      toggleLoading();
    }
  }

  Future<void> getBookmarks() async {
    try {
      toggleLoading();
      final response = await BookmarkApi.getBookmarks(getId()!);

      final List<dynamic>? jobIds = response['job_ids'];
      if (jobIds != null) {
        final List<Job> bookmarkedJobs =
            await Future.wait(jobIds.map((jobId) async {
          final jobResponse = await JobApi.getJobById(jobId);
          return Job.fromJson(jobResponse);
        }).toList());

        _bookmarkJobs.value = bookmarkedJobs;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      toggleLoading();
    }
  }

  Future<bool> getBookmarkStatus(String jobId) async {
    try {
      toggleLoading();
      final status = await BookmarkApi.checkBookmarkExists(
          jobseekerId: getId()!, jobId: jobId);
      return status;
    } catch (error) {
      return false;
    } finally {
      toggleLoading();
    }
  }
}
