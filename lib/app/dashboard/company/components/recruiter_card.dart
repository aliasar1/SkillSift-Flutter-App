import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/models/recruiter_model.dart';
import '../../../../core/widgets/custom_text.dart';
import 'add_recruiter_screen.dart';

class RecruiterCard extends StatelessWidget {
  const RecruiterCard({
    super.key,
    required this.recruiter,
  });

  final Recruiter recruiter;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: LightTheme.greyShade1,
      leading: const Icon(Icons.person),
      title: Txt(
        title: recruiter.fullName,
        fontContainerWidth: double.infinity,
        textAlign: TextAlign.start,
        textStyle: const TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Txt(
        title: recruiter.role,
        fontContainerWidth: double.infinity,
        textAlign: TextAlign.start,
        textStyle: const TextStyle(
          fontFamily: "Poppins",
          color: LightTheme.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Get.to(AddRecruiterScreen(
            isEdit: true,
            recruiter: recruiter,
          ));
        },
        icon: const Icon(Icons.edit),
        color: LightTheme.primaryColor,
      ),
    );
  }
}
