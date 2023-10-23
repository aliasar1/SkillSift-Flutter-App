import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';

class SliderContentBuilder extends StatelessWidget {
  const SliderContentBuilder({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title, description, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.15,
        ),
        SvgPicture.asset(
          imageUrl,
          height: Sizes.SIZE_120 * 2,
          width: Sizes.SIZE_120 * 2,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(
          height: 10,
        ),
        Txt(
          title: title,
          fontContainerWidth: 270,
          textStyle: const TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.primaryColor,
            fontSize: Sizes.TEXT_SIZE_30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Txt(
          title: description,
          fontContainerWidth: 320,
          textStyle: const TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
