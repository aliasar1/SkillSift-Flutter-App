import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isObscure = true.obs;
  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleIsChecked() {
    isChecked.value = !isChecked.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
