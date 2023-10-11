import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/features/authenticate/controllers/slider_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/login_screen.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text.dart';

import '../../../constants/constants.dart';
import '../components/get_started_button.dart';
import '../components/slider_content_builder.dart';

class IntroSlider extends StatelessWidget {
  IntroSlider({super.key});

  final sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          sliderController.decrementPosition();
        } else {
          sliderController.incrementPosition();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
              vertical: Sizes.MARGIN_12, horizontal: Sizes.MARGIN_18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => sliderController.getPosition == 2
                    ? Container()
                    : Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.offAll(LoginScreen());
                            },
                            child: const Txt(
                              fontContainerWidth: 40,
                              title: "Skip",
                              textStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: AppColors.secondaryColorDark,
                                  fontSize: Sizes.TEXT_SIZE_16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
              ),
              Obx(() {
                return Expanded(
                  child: Column(
                    children: [
                      if (sliderController.getPosition == 0)
                        const SliderContentBuilder(
                          imageUrl: "assets/images/interview.svg",
                          title: "Find and land your next job",
                          description:
                              "Daily job postings on your fingertips - never miss out your next career move",
                        )
                      else if (sliderController.getPosition == 1)
                        const SliderContentBuilder(
                          imageUrl: "assets/images/search.svg",
                          title: "Find The Perfect Candidates",
                          description:
                              "Our app provide AI expert system in order to perfectly pick the best candidates that suits the job description",
                        )
                      else
                        const Expanded(
                          child: Column(
                            children: [
                              SliderContentBuilder(
                                imageUrl: "assets/images/test.svg",
                                title: "In-App QnA And Test",
                                description:
                                    "QnA and Test features are provided in App to evaluate the candidates",
                              ),
                              GetStartedButton(),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => sliderController.getPosition == 0
                        ? Container(width: 45)
                        : IconButton(
                            onPressed: () {
                              sliderController.decrementPosition();
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  Obx(
                    () => DotsIndicator(
                      dotsCount: 3,
                      position: sliderController.getPosition,
                      decorator: DotsDecorator(
                        color: AppColors.greyShade8,
                        activeColor: AppColors.secondaryColorDark,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => sliderController.getPosition == 2
                        ? Container(width: 45)
                        : IconButton(
                            onPressed: () {
                              sliderController.incrementPosition();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.secondaryColorDark,
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
