import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../exports/constants_exports.dart';
import '../custom_text.dart';

class NoJobsAddedTemplate extends StatelessWidget {
  const NoJobsAddedTemplate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.NO_JOB_ADDED,
            height: Sizes.ICON_SIZE_50 * 4,
            width: Sizes.ICON_SIZE_50 * 4,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Txt(
              title: "No jobs are added yet!",
              fontContainerWidth: double.infinity,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.secondaryColor,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: Sizes.HEIGHT_160),
        ],
      ),
    );
  }
}