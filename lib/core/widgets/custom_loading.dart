import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';
import 'package:skillsift_flutter_app/core/constants/theme/light_theme.dart';

class LoadingDialog {
  static bool isLoading = false;

  static void showLoadingDialog(BuildContext context, String message) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircularProgressIndicator(
                  color: LightTheme.primaryColor,
                ),
                const SizedBox(height: 16.0),
                Text(
                  message,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  static void hideLoadingDialog(BuildContext context) {
    if (isLoading) {
      Navigator.of(context).pop();
      isLoading = false;
    }
  }
}
