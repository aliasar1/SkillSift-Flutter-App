import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/features/home/views/home_screen.dart';

import '../models/user_model.dart' as model;
import '../constants/firebase.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final signupUserFormKey = GlobalKey<FormState>();
  final signupCompanyFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final companySizeController = TextEditingController();
  final companyIndustryController = TextEditingController();
  final contactNumberController = TextEditingController();
  final confirmPassController = TextEditingController();
  final street1Controller = TextEditingController();
  final street2Controller = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();

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
    isLoading.value == true ? isLoading.value = false : isLoading.value = true;
  }

  void clearFields() {
    emailController.clear();
    passController.clear();
    nameController.clear();
    companySizeController.clear();
    companyIndustryController.clear();
    contactNumberController.clear();
    confirmPassController.clear();
    street1Controller.clear();
    street2Controller.clear();
    cityController.clear();
    countryController.clear();
    postalCodeController.clear();
  }

  Future<void> signUpUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    try {
      if (signupUserFormKey.currentState!.validate()) {
        signupUserFormKey.currentState!.save();
        toggleLoading();
        if (password != confirmPassword) {
          Get.snackbar(
            'Failed!',
            'Password and confirm pasword doesn not match.',
          );
          toggleLoading();
          return;
        }
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // await firebaseAuth.currentUser!.sendEmailVerification();

        model.User user = model.User(
          fullName: name,
          uid: cred.user!.uid,
          phone: "",
          email: email,
          profilePhoto: "",
          address: "",
        );

        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        toggleLoading();

        Get.snackbar(
          'Account created successfully!',
          'Please verify account to proceed.',
        );

        Get.offAll(HomeScreen());
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error signing up',
        e.toString(),
      );
    }
  }

  Future<void> registerCompany({
    required String companyName,
    required String industryOrSector,
    required String companySize,
    required String location,
    required String contactNo,
    required String contactEmail,
    required String password,
    required String street1,
    String street2 = '',
    required String city,
    required String country,
    required String postalCode,
    required bool termsAndConditionsAccepted,
  }) async {
    try {
      // Validation logic here...

      toggleLoading();

      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: contactEmail,
        password: password,
      );

      Map<String, dynamic> companyData = {
        'companyName': companyName,
        'industryOrSector': industryOrSector,
        'companySize': companySize,
        'contactNumber': contactNo,
        'contactEmail': contactEmail,
        'password': password,
        'termsAndConditions': termsAndConditionsAccepted,
        'street1': street1,
        'street2': street2,
        'city': city,
        'country': country,
        'postalCode': postalCode,
        'location': location,
        'uid': cred.user!.uid,
      };

      // Save the company data to Firestore
      await firestore
          .collection("companies")
          .doc(cred.user!.uid)
          .set(companyData);

      toggleLoading();

      Get.snackbar(
        'Account created successfully!',
        'Please verify account to proceed.',
      );

      Get.offAll(HomeScreen());
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error signing up',
        e.toString(),
      );
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        toggleLoading(); // Show loading indicator

        UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        toggleLoading(); // Hide loading indicator after successful login

        if (cred.user != null) {
          // Successfully logged in
          Get.offAll(
              HomeScreen()); // Navigate to home screen or any desired screen
        } else {
          // Handle the case when user is null (should not happen in normal login scenarios)
          Get.snackbar(
            'Error',
            'Invalid credentials. Please try again.',
          );
        }
      }
    } catch (e) {
      toggleLoading(); // Hide loading indicator in case of error
      Get.snackbar(
        'Error',
        e.toString(), // Display the error message to the user
      );
    }
  }
}
