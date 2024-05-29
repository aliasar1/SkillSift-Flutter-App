import 'package:flutter/material.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  static const routeName = '/notifications';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: isDarkMode ? LightTheme.white : Colors.black),
        backgroundColor:
            isDarkMode ? DarkTheme.backgroundColor : LightTheme.whiteShade2,
        title: Txt(
          textAlign: TextAlign.start,
          title: "Notifications",
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: isDarkMode ? LightTheme.white : LightTheme.black,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: isDarkMode
                    ? DarkTheme.containerColor
                    : LightTheme.scaffoldColor,
                leading: const Icon(
                  Icons.group,
                  color: LightTheme.primaryColor,
                ),
                title: Txt(
                  textAlign: TextAlign.start,
                  title: "Job Added",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: isDarkMode ? LightTheme.white : LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Txt(
                  textAlign: TextAlign.start,
                  title: "Flutter Developer job available. Check it out now!",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: isDarkMode ? LightTheme.white : LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: const Icon(
                  Icons.send,
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          }),
    );
  }
}
