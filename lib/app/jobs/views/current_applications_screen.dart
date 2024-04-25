import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

import '../../../core/constants/sizes.dart';
import '../../../core/widgets/custom_text.dart';
import 'applicant_details_screen.dart';

class CurrentApplicationScreen extends StatelessWidget {
  const CurrentApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: LightTheme.whiteShade2,
        iconTheme: const IconThemeData(color: LightTheme.black),
        title: const Txt(
          title: "Applications",
          textAlign: TextAlign.start,
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.secondaryColor,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(ApplicantDetailsScreen());
                },
                child: ListTile(
                  tileColor: LightTheme.cardLightShade,
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: SizedBox(
                    width: Get.width * 0.5,
                    child: const Txt(
                      textAlign: TextAlign.start,
                      title: "Ali Asar",
                    ),
                  ),
                  subtitle: SizedBox(
                    width: Get.width * 0.5,
                    child: const Txt(
                      textAlign: TextAlign.start,
                      title: "CV Rating: 78.3%",
                    ),
                  ),
                  trailing: SizedBox(
                    width: Get.width * 0.25,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_box,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
