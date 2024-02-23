import 'package:flutter/material.dart';

import '../exports/constants_exports.dart';
import '../exports/widgets_export.dart';

class CompanyVerficationContainer extends StatelessWidget {
  const CompanyVerficationContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16),
        height: 320,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: LightTheme.grey,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: LightTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: const Icon(Icons.warning, color: Colors.white, size: 100),
            ),
            const SizedBox(height: Sizes.HEIGHT_24),
            const Txt(
              title: "Account Activation Required",
              textAlign: TextAlign.center,
              fontContainerWidth: 260,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontSize: Sizes.TEXT_SIZE_16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Sizes.HEIGHT_18),
            const Txt(
              title:
                  "Please complete your company details in order to activate your account.",
              textAlign: TextAlign.center,
              fontContainerWidth: 280,
              textStyle: TextStyle(
                fontFamily: "Poppins",
                color: LightTheme.black,
                fontSize: Sizes.TEXT_SIZE_14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: Sizes.HEIGHT_14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(LightTheme.white),
                    foregroundColor:
                        MaterialStateProperty.all(LightTheme.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  child: const Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(LightTheme.primaryColor),
                    foregroundColor:
                        MaterialStateProperty.all(LightTheme.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                  child: const Text('Complete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
