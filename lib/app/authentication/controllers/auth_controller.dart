import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/views/dashboard.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/views_exports.dart';
import '../../../core/models/user_model.dart' as model;

class AuthController extends GetxController with CacheManager {
  final loginFormKey = GlobalKey<FormState>();
  final signupUserFormKey = GlobalKey<FormState>();
  final signupCompanyFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isChecked = false.obs;
  Rx<bool> isLoading = false.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final companySizeController = TextEditingController();
  final companyIndustryController = TextEditingController();
  final contactNumberController = TextEditingController();
  final confirmPassController = TextEditingController();
  final street1Controller = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final resetEmailController = TextEditingController();

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

  void clearFields() {
    emailController.clear();
    passController.clear();
    nameController.clear();
    companySizeController.clear();
    companyIndustryController.clear();
    contactNumberController.clear();
    confirmPassController.clear();
    street1Controller.clear();
    cityController.clear();
    countryController.clear();
    postalCodeController.clear();
    resetEmailController.clear();
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

        await firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': email,
          'type': 'jobseeker',
        });

        model.User user = model.User(
          fullName: name,
          uid: cred.user!.uid,
          phone: "",
          email: email,
          profilePhoto: "",
          address: "",
        );

        await firestore
            .collection("jobseekers")
            .doc(cred.user!.uid)
            .set(user.toJson());

        toggleLoading();

        Get.snackbar(
          'Account created successfully!',
          'Please verify account to proceed.',
        );
        setLoginStatus(true);
        clearFields();
        Get.offAll(DashboardScreen());
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error signing up',
        e.toString(),
      );
    }
  }

  Future<void> registerCompany(
      {required String companyName,
      required String industryOrSector,
      required String companySize,
      required String location,
      required String contactNo,
      required String contactEmail,
      required String password,
      required String street1,
      required String city,
      required String country,
      required String postalCode,
      required bool termsAndConditionsAccepted,
      required BuildContext context}) async {
    if (signupCompanyFormKey.currentState!.validate()) {
      signupCompanyFormKey.currentState!.save();
      if (!termsAndConditionsAccepted) {
        Get.snackbar('Confirm Terms and Conditions',
            'Please confitms terms and condition to create account.');
      }
      try {
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
          'city': city,
          'country': country,
          'postalCode': postalCode,
          'location': location,
          'uid': cred.user!.uid,
        };

        await firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': contactEmail,
          'type': 'company',
        });

        // Save the company data to Firestore
        await firestore
            .collection("companies")
            .doc(cred.user!.uid)
            .set(companyData);

        Get.snackbar(
          'Account created successfully!',
          'Please verify account to proceed.',
        );
        setLoginStatus(true);
        clearFields();
        Get.offAll(DashboardScreen());
      } catch (e) {
        Get.snackbar(
          'Error signing up',
          e.toString(),
        );
      }
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (loginFormKey.currentState!.validate()) {
        loginFormKey.currentState!.save();
        toggleLoading();

        if (isChecked.value) {
          setLoginStatus(true);
        }
        UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(cred.user!.uid).get();
        final type = userSnapshot['type'];
        setUserType(type);

        toggleLoading();
        clearFields();
        if (cred.user != null) {
          Get.offAll(DashboardScreen());
        } else {
          Get.snackbar(
            'Error',
            'Invalid credentials. Please try again.',
          );
        }
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  void resetPassword(String email) async {
    if (resetPasswordFormKey.currentState!.validate()) {
      try {
        toggleLoading();
        await firebaseAuth.sendPasswordResetEmail(email: email);
        toggleLoading();
        Get.back(closeOverlays: true);
        Get.snackbar(
          'Success',
          'Password reset email is send successfully.',
        );
      } catch (err) {
        toggleLoading();
        Get.snackbar(
          'Error',
          err.toString(),
        );
      }
    }
  }

  void checkLoginStatus() {
    final user = getLoginStatus();
    if (user == null || user == false) {
      final sliderStatus = getSliderWatchStatus();
      if (sliderStatus == null) {
        Get.offAll(IntroScreen());
      } else {
        Get.offAll(LoginScreen());
      }
    } else {
      Get.offAll((DashboardScreen()));
    }
  }

  void logout() async {
    setLoginStatus(false);
    setUserType(null);
    await firebaseAuth.signOut();
    Get.offAll(LoginScreen());
  }
}
