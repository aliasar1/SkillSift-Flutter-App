import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/features/authenticate/views/login_screen.dart';

import '../../../constants/firebase.dart';
import '../../../widgets/custom_widgets/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Txt(title: "HOME PAGE"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            firebaseAuth.signOut();
            Get.offAll(LoginScreen());
          },
          child: const Icon(Icons.logout)),
    );
  }
}
