import 'package:flutter/material.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/widgets_export.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: LightTheme.white),
        backgroundColor: LightTheme.primaryColor,
        title: const Txt(
          textAlign: TextAlign.start,
          title: "Notifications",
          fontContainerWidth: double.infinity,
          textStyle: TextStyle(
            fontFamily: "Poppins",
            color: LightTheme.white,
            fontSize: Sizes.TEXT_SIZE_18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: LightTheme.scaffoldColor,
                leading: Icon(
                  Icons.group,
                  color: LightTheme.primaryColor,
                ),
                title: Txt(
                  textAlign: TextAlign.start,
                  title: "Job Added",
                  fontContainerWidth: double.infinity,
                  textStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: LightTheme.black,
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
                    color: LightTheme.black,
                    fontSize: Sizes.TEXT_SIZE_12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  Icons.send,
                  color: LightTheme.primaryColor,
                ),
              ),
            );
          }),
    ));
  }
}
