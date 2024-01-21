import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/controllers/recruiter_controller.dart';
import 'package:skillsift_flutter_app/core/models/recruiter_model.dart';

class RecruiterSearchController extends GetxController {
  final Rx<List<Recruiter>> _searchedRecruiters = Rx<List<Recruiter>>([]);
  List<Recruiter> get searchedRecruiters => _searchedRecruiters.value;

  Future<void> searchRecruiters(
      String typedUser, RecruiterController controller) async {
    if (typedUser.isEmpty) {
      _searchedRecruiters.value = [];
      return;
    }

    List<Recruiter> retVal = [];

    for (var recruiter in controller.recruiters) {
      if (recruiter.fullName.toLowerCase().contains(typedUser.toLowerCase())) {
        retVal.add(recruiter);
      }
    }

    _searchedRecruiters.value = retVal;
  }
}
