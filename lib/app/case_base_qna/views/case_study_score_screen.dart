import 'package:flutter/material.dart';

class CaseStudyScoreScreen extends StatelessWidget {
  const CaseStudyScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Container(
            child: Text("STUDY DONE!"),
          ),
        ),
      ),
    );
  }
}
