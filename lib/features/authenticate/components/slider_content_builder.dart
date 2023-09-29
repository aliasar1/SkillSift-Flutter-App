import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

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
    return Expanded(
      child: Column(
        children: [
          const Spacer(),
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
                color: AppColors.secondaryColorDark,
                fontSize: Sizes.TEXT_SIZE_30,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Txt(
            title: description,
            fontContainerWidth: 320,
            textStyle: const TextStyle(
                fontFamily: "Poppins",
                color: AppColors.black,
                fontSize: Sizes.TEXT_SIZE_14,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
