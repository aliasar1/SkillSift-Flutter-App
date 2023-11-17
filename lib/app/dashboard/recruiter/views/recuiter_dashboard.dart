import 'package:flutter/material.dart';

import '../../../../core/constants/theme/light_theme.dart';

class RecruiterDashboard extends StatelessWidget {
  const RecruiterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      backgroundColor: LightTheme.whiteShade2,
      body: Center(
        child: Text('This is recruiter dashboard!'),
      ),
    ));
  }
}
