import 'package:flutter/material.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(role)),
    );
  }
}
