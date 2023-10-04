import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final companySizeController = TextEditingController();
  final contactNumberController = TextEditingController();
  final confirmPassController = TextEditingController();

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleVisibility1() {
    isObscure1.value = !isObscure1.value;
  }

  void toggleIsChecked() {
    isChecked.value = !isChecked.value;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}
