import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/dashboard/company/views/company_dashboard.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/views_exports.dart';
import '../../../core/models/user_model.dart' as model;
import '../../../core/services/place_api.dart';
import '../../dashboard/jobseeker/views/jobs_dashboard.dart';

class AuthController extends GetxController with CacheManager {
  final loginFormKey = GlobalKey<FormState>();
  final signupUserFormKey = GlobalKey<FormState>();
  final signupCompanyFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isChecked = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLocationPicked = false.obs;

  RxList<double> location = <double>[].obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final companySizeController = TextEditingController(text: 'Small (0-10)');
  final companyIndustryController =
      TextEditingController(text: 'Information Technology');
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

  void toggleIsLocPicked() {
    isLocationPicked.value = !isLocationPicked.value;
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
    isChecked.value = false;
    resetEmailController.clear();
  }

  Future<void> getPlaceDetails(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json', {
      "place_id": placeId,
      "key": 'AIzaSyAC41qD4CKnJGwlWAXs46TPoBvxwLwc5e4',
    });

    String? response = await PlaceApi.fetchUrl(uri);

    Map<String, dynamic> data = json.decode(response!);
    double? latitude = data['result']['geometry']['location']['lat'];
    double? longitude = data['result']['geometry']['location']['lng'];

    if (latitude != null && longitude != null) {
      location.value = [latitude, longitude];
    }
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

        await firebaseAuth.currentUser!.sendEmailVerification();

        await firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': email,
          'type': 'jobseekers',
          'verificationStatus': 'approved',
          'verifiedBy': '',
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

        clearFields();
        Get.offAll(LoginScreen());
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

      try {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: contactEmail,
          password: password,
        );

        await firebaseAuth.currentUser!.sendEmailVerification();

        GeoPoint geoPoint = GeoPoint(location[0], location[1]);

        Map<String, dynamic> companyData = {
          'companyName': companyName,
          'industryOrSector': industryOrSector,
          'companySize': companySize,
          'contactNumber': contactNo,
          'contactEmail': contactEmail,
          'termsAndConditions': termsAndConditionsAccepted,
          'street1': street1,
          'city': city,
          'country': country,
          'postalCode': postalCode,
          'location': geoPoint,
          'uid': cred.user!.uid,
        };

        await firestore.collection('users').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'email': contactEmail,
          'type': 'companies',
          'verificationStatus': 'pending',
          'verifiedBy': '',
        });

        await firestore
            .collection("companies")
            .doc(cred.user!.uid)
            .set(companyData);

        Get.snackbar(
          'Account created successfully!',
          'Please verify account to proceed.',
        );

        clearFields();
        Get.offAll(LoginScreen());
      } catch (e) {
        Get.snackbar(
          'Error signing up',
          e.toString(),
        );
      }
    }
  }

  Future<bool> loginUser({
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
        // final verificationStatus = userSnapshot['verificationStatus'];

        final user = cred.user;

        if (user != null) {
          setUserType(type);
          setLoginStatus(true);
          toggleLoading();

          return true;
          // if (verificationStatus == 'approved') {
          //   return true;
          // } else if (verificationStatus == 'pending') {
          //   return false;
          // } else {
          //   // verificationStatus == 'rejected'
          //   return false;
          // }
        } else {
          toggleLoading();
          Get.snackbar(
            'Error',
            'Invalid credentials. Please try again.',
          );
          return false;
        }
      }
      return false;
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error',
        e.toString(),
      );
      return false;
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
    print(user);
    if (user == null || user == false) {
      final sliderStatus = getSliderWatchStatus();

      if (sliderStatus == null) {
        Get.offAll(IntroScreen());
      } else {
        Get.offAll(LoginScreen());
      }
    } else {
      setUserType('companies');
      final type = getUserType();
      if (type == 'companies') {
        Get.offAll(CompanyDashboard());
      } else if (type == 'jobseekers') {
        Get.offAll((DashboardScreen()));
      } else {}
    }
  }

  void logout() async {
    setLoginStatus(false);
    setUserType(null);
    await firebaseAuth.signOut();
    Get.offAll(LoginScreen());
  }
}
