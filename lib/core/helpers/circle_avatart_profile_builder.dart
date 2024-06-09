import 'package:flutter/material.dart';

import '../constants/theme/light_theme.dart';

CircleAvatar buildCircularAvatar(String profilePicUrl, double radius) {
  return CircleAvatar(
    backgroundColor: LightTheme.grey,
    backgroundImage: profilePicUrl.isEmpty
        ? const NetworkImage(
            'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
          )
        : NetworkImage(
            profilePicUrl,
          ),
    radius: radius,
  );
}
