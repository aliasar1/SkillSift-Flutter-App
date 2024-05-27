import 'package:flutter/material.dart';
import 'package:skillsift_flutter_app/core/constants/theme/dark_theme.dart';

import '../constants/theme/light_theme.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Icon(
            Icons.location_on,
            color: isDarkMode ? DarkTheme.whiteGreyColor : LightTheme.black,
          ),
          minLeadingWidth: 40,
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
