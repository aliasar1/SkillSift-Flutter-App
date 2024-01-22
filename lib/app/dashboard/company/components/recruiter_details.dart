import 'package:flutter/material.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/models/recruiter_model.dart';
import '../../../../core/widgets/custom_text.dart';

class RecruiterDetailsScreen extends StatelessWidget {
  const RecruiterDetailsScreen({super.key, required this.recruiter});

  final Recruiter recruiter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: LightTheme.white),
        backgroundColor: LightTheme.primaryColor,
        title: const Txt(
          textAlign: TextAlign.start,
          title: "Recruiter Details",
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.white,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Sizes.MARGIN_12,
            vertical: Sizes.MARGIN_12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Sizes.SIZE_20),
              CircleAvatar(
                radius: 64,
                backgroundImage: recruiter.profilePhoto != ""
                    ? Image.network(recruiter.profilePhoto).image
                    : const NetworkImage(
                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                backgroundColor: LightTheme.blackShade4,
              ),
              const SizedBox(height: Sizes.SIZE_20),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              const SizedBox(height: Sizes.SIZE_12),
              Txt(
                textAlign: TextAlign.center,
                title: "Full Name: ${recruiter.fullName}",
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Txt(
                textAlign: TextAlign.center,
                title: "Employee ID: ${recruiter.employeeId}",
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Sizes.SIZE_12),
              const Divider(
                height: 2,
                thickness: 1,
              ),
              const SizedBox(height: Sizes.SIZE_20),
              Txt(
                textAlign: TextAlign.center,
                title: "Email: ${recruiter.email}",
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: Sizes.SIZE_12),
              Txt(
                textAlign: TextAlign.center,
                title:
                    "Contact Number: ${recruiter.phone == "" ? 'NA' : recruiter.phone}",
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: Sizes.SIZE_12),
              Txt(
                textAlign: TextAlign.center,
                title: "Role: ${recruiter.role}",
                fontContainerWidth: double.infinity,
                textStyle: const TextStyle(
                  fontFamily: "Poppins",
                  color: LightTheme.black,
                  fontSize: Sizes.TEXT_SIZE_14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
