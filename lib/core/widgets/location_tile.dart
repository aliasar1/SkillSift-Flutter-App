import 'package:flutter/material.dart';

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
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon(
            Icons.location_on,
            color: LightTheme.black,
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
