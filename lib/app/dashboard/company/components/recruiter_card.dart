import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/theme/light_theme.dart';
import '../../../../core/models/recruiter_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../controllers/recruiter_controller.dart';
import 'add_recruiter_screen.dart';

class RecruiterCard extends StatelessWidget {
  const RecruiterCard({
    super.key,
    required this.recruiter,
    required this.controller,
  });

  final Recruiter recruiter;
  final RecruiterController controller;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(recruiter.uid),
      background: Container(
        color: LightTheme.primaryColorLightShade,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: LightTheme.whiteShade2,
            title: const Txt(
              title: 'Are you sure?',
              fontContainerWidth: double.infinity,
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Txt(
              title: 'Do you want to remove the recruiter?',
              fontContainerWidth: double.infinity,
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Txt(
                  title: 'No',
                  fontContainerWidth: 40,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  Get.back(result: false);
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(LightTheme.primaryColor),
                ),
                child: const Txt(
                  title: 'Yes',
                  fontContainerWidth: 40,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        controller.deleteRecruiter(recruiter);
      },
      child: ListTile(
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
              controller: controller,
            ));
          },
          icon: const Icon(Icons.edit),
          color: LightTheme.primaryColor,
        ),
      ),
    );
  }
}
