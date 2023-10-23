import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/authentication/views/login.dart';

import '../components/slider_content_builder.dart';

class SliderController extends GetxController {
  List<Widget> listCustomTabs = [];

  @override
  void onInit() {
    super.onInit();
    listCustomTabs.add(const SliderContentBuilder(
      imageUrl: "assets/images/interview.svg",
      title: "Find and land your next job",
      description:
          "Daily job postings on your fingertips - never miss out your next career move",
    ));
    listCustomTabs.add(const SliderContentBuilder(
      imageUrl: "assets/images/search.svg",
      title: "Find The Perfect Candidates",
      description:
          "Our app provide AI expert system in order to perfectly pick the best candidates that suits the job description",
    ));
    listCustomTabs.add(
      const SliderContentBuilder(
        imageUrl: "assets/images/test.svg",
        title: "In-App QnA And Test",
        description:
            "QnA and Test features are provided in App to evaluate the candidates",
      ),
    );
  }

  void onDoneOrSkipPress() {
    Get.offAll(LoginScreen());
  }
}
