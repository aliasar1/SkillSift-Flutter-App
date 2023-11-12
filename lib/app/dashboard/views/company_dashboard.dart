import 'package:flutter/material.dart';

class CompanyDashboard extends StatelessWidget {
  const CompanyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text("I AM COMPANY DASHBOARD!"),
      ),
    ));
  }
}
