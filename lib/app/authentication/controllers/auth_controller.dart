import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/exports/constants_exports.dart';
import '../../../core/exports/views_exports.dart';
import '../../../core/helpers/encryption.dart';
import '../../../core/local/cache_manager.dart';
import '../../../core/models/user_model.dart' as model;
import '../../../core/services/auth_api.dart';
import '../../../core/services/place_api.dart';
import '../components/drafft.dart';
import '../components/update_password.dart';
import '../views/login.dart';

class AuthController extends GetxController with CacheManager {
  final loginFormKey = GlobalKey<FormState>();
  final signupUserFormKey = GlobalKey<FormState>();
  final signupCompanyFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();
  final updatePasswordFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isChecked = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLocationPicked = false.obs;

  RxList<double> location = <double>[].obs;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final companySizeController = TextEditingController(text: 'Small (0-10)');
  final companyIndustryController =
      TextEditingController(text: 'Information Technology');
  final contactNumberController = TextEditingController();
  final street1Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final resetEmailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final oldPassController = TextEditingController();

  void toggleVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleVisibility1() {
    isObscure1.value = !isObscure1.value;
  }

  void toggleVisibility2() {
    isObscure2.value = !isObscure2.value;
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
    isLocationPicked.value = false;
    resetEmailController.clear();
    oldPassController.clear();
    stateController.clear();
    isLoading.value = false;
  }

  void updatePassword(String? email, String oldPass, String newPassword) async {
    if (updatePasswordFormKey.currentState!.validate()) {
      updatePasswordFormKey.currentState!.save();
      // try {
      //   toggleLoading();
      //   UserCredential userCred = await firebaseAuth.signInWithEmailAndPassword(
      //       email: email!, password: oldPass);
      //   User? user = firebaseAuth.currentUser;
      //   if (user != null) {
      //     await userCred.user!.updatePassword(newPassword);
      //     DocumentSnapshot snap = await firestore
      //         .collection('users')
      //         .doc(firebaseAuth.currentUser!.uid)
      //         .get();
      //     final companyId = snap['verifiedBy'];

      //     final salt = Encryption.generateRandomKey(16);
      //     Encrypted encryptedPass = Encryption.encrypt(salt, newPassword);

      //     await firestore
      //         .collection('companies')
      //         .doc(companyId)
      //         .collection('recruiters')
      //         .doc(firebaseAuth.currentUser!.uid)
      //         .update(
      //       {
      //         'isPassChanged': true,
      //         'pass': {'salt': salt, 'encryptedPass': encryptedPass.base64},
      //       },
      //     );
      //     Get.snackbar(
      //       'Password Updated',
      //       'Login to your account to continue.',
      //     );
      //     logout();
      //     Get.offAll(LoginScreen());
      //     clearFields();
      //   } else {
      //     Get.snackbar(
      //       'User not found',
      //       'Please provide correct email and password.',
      //     );
      //   }
      //   toggleLoading();
      // } catch (e) {
      //   toggleLoading();
      //   Get.snackbar(
      //     'Error signing up',
      //     e.toString(),
      //   );
      // }
    }
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

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String contactNumber,
    required String name,
    required bool isRecruiter,
  }) async {
    try {
      if (signupUserFormKey.currentState!.validate()) {
        signupUserFormKey.currentState!.save();

        if (password != confirmPassword) {
          Get.snackbar(
            'Failed!',
            'Password and confirm password do not match.',
          );
          return;
        }

        toggleLoading();

        // Call the API to register the job seeker
        final response = await AuthApi.register(
          fullname: name,
          email: email,
          password: password,
          contactNo: contactNumber,
          isRecruiter: isRecruiter,
        );

        toggleLoading();

        if (response.containsKey('error')) {
          Get.snackbar(
            'Error signing up',
            response['error'],
          );
        } else {
          if (response['statusCode'] == 201) {
            Get.snackbar(
              'Account created successfully!',
              'Login to your account to continue.',
            );

            // Clear form fields after successful registration
            clearFields();

            // Navigate to login screen
            Get.offAll(LoginScreen());
          } else {
            Get.snackbar(
              'Error signing up',
              'Failed to register. Please try again later.',
            );
          }
        }
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error signing up',
        e.toString(),
      );
    }
  }

  bool checkIfCSCIsFilled() {
    if (countryController.text.isEmpty ||
        stateController.text.isEmpty ||
        cityController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future<bool> registerCompany({
    required String companyName,
    required String industryOrSector,
    required String companySize,
    required String contactNo,
    required String contactEmail,
    required String password,
    required String street1,
    required String city,
    required String state,
    required String country,
    required String postalCode,
    required bool termsAndConditionsAccepted,
  }) async {
    if (signupCompanyFormKey.currentState!.validate()) {
      signupCompanyFormKey.currentState!.save();

      if (!isLocationPicked.value ||
          !isChecked.value ||
          contactNumberController.text.isEmpty) {
        return false;
      }

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
          'state': state,
          'country': country,
          'postalCode': postalCode,
          'location': geoPoint,
          'uid': cred.user!.uid,
          'profilePhoto': "", // add ons
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

        clearFields();
        return true;
      } catch (e) {
        Get.snackbar(
          'Error signing up',
          e.toString(),
        );
        return false;
      }
    } else {
      return false;
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

        final response = await AuthApi.login(
          email: email,
          password: password,
        );

        toggleLoading();

        if (response.containsKey('error')) {
          Get.snackbar(
            'Login Failed',
            response['error'],
          );
        } else {
          if (isChecked.value) {
            setLoginStatus(true);
          }
          Get.offAll(DraftScreen(
            role: response['role'],
          ));
        }
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error',
        'An error occurred while logging in: $e',
      );
    }
  }

  void resetPassword(String email) async {
    if (resetPasswordFormKey.currentState!.validate()) {
      try {
        toggleLoading();
        bool adminEmailExists = await checkIfEmailExists(email);
        if (adminEmailExists) {
          toggleLoading();
          Get.back(closeOverlays: true);
          Get.snackbar(
            'Request Faild',
            'Make sure to provide correcr email.',
          );
        } else {
          await firebaseAuth.sendPasswordResetEmail(email: email);
          toggleLoading();
          Get.back(closeOverlays: true);
          Get.snackbar(
            'Success',
            'Password reset email is send successfully.',
          );
        }
      } catch (err) {
        toggleLoading();
        Get.snackbar(
          'Error',
          err.toString(),
        );
      }
    }
  }

  Future<bool> checkIfEmailExists(String userEmail) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .where('email', isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
      return false;
    }
  }

  void checkLoginStatus() {
    Get.offAll(LoginScreen());
    // final user = getLoginStatus();
    // if (user == null || user == false) {
    //   //   final sliderStatus = getSliderWatchStatus();

    //   //   if (sliderStatus == null) {
    //   //     Get.offAll(IntroScreen());
    //   //   } else {
    //   //     Get.offAll(LoginScreen());
    //   //   }
    //   // } else {
    //   //   final type = getUserType();
    //   //   if (type == 'companies') {
    //   //     Get.offAll(CompanyDashboard());
    //   //   } else if (type == 'jobseekers') {
    //   //     Get.offAll((DashboardScreen()));
    //   //   } else {
    //   //     Get.offAll(RecruiterDashboard());
    //   //   }
    // }
  }

  void logout() async {
    setLoginStatus(false);
    setUserType(null);
    removeEmail();
    removePass();
    removeCompanyId();
    await firebaseAuth.signOut();
    Get.offAll(LoginScreen());
  }
}
