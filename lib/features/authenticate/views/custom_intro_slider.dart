import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skillsift_flutter_app/widgets/custom_widgets/custom_text.dart';

import '../../../constants/constants.dart';

class IntroCustomSlider extends StatefulWidget {
  const IntroCustomSlider({super.key});

  @override
  State<IntroCustomSlider> createState() => _IntroCustomSliderState();
}

class _IntroCustomSliderState extends State<IntroCustomSlider> {
  List<Widget> listCustomTabs = [
    const SliderPageContent(
      imageUrl: "assets/images/search.svg",
      title: "Search Best Jobs",
      description: "Filter out the best jobs that suits your skills",
    ),
    const SliderPageContent(
      imageUrl: "assets/images/candidate.svg",
      title: "Find The Perfect Candidates",
      description:
          "Our app provide AI expert system in order to perfectly pick the best candidates that suits the job description",
    ),
    const SliderPageContent(
      imageUrl: "assets/images/test.svg",
      title: "In-App QnA And Test",
      description:
          "QnA and Test features are provided in App to evaluate the candidates",
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() {}

  ButtonStyle buttonStyle = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(AppColors.secondaryColorDark));

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      backgroundColorAllTabs: AppColors.scaffoldColor,
      listCustomTabs: listCustomTabs,
      skipButtonStyle: buttonStyle,
      nextButtonStyle: buttonStyle,
      onDonePress: onDonePress,
    );
  }
}

class SliderPageContent extends StatelessWidget {
  const SliderPageContent(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description});

  final String imageUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: Sizes.MARGIN_20, horizontal: Sizes.MARGIN_20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Txt(
              title: title,
              fontContainerWidth: double.infinity,
              textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: AppColors.secondaryColorDark,
                fontSize: Sizes.TEXT_SIZE_20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: Sizes.HEIGHT_16,
            ),
            SvgPicture.asset(
              imageUrl,
              height: Sizes.SIZE_120 * 2.5,
              width: Sizes.SIZE_120 * 2.5,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              height: Sizes.HEIGHT_16,
            ),
            Txt(
              title: description,
              fontContainerWidth: double.infinity,
              textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: AppColors.secondaryColorDark,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
