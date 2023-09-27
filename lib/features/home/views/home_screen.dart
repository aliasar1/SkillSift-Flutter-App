import 'package:flutter/material.dart';

import '../../../widgets/custom_widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Txt(title: "HOME PAGE"),
      ),
    );
  }
}
