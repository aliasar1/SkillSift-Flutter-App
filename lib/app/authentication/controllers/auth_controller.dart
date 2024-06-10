import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skillsift_flutter_app/app/recruiter/views/recruiter_dashboard.dart';
import 'package:skillsift_flutter_app/core/services/company_api.dart';

import '../../../core/local/cache_manager.dart';
import '../../../core/models/company_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/models/user_model.dart' as model;
import '../../../core/services/auth_api.dart';
import '../../../core/services/fcm_api.dart';
import '../../../core/services/place_api.dart';
import '../../jobseeker/views/jobseeker_dashboard.dart';
import '../views/login.dart';

class AuthController extends GetxController with CacheManager {
  final _firebaseMessaging = FirebaseMessaging.instance;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupUserFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupCompanyFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

  RxBool isObscure = true.obs;
  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isChecked = false.obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLocationPicked = false.obs;

  int? companyId;
  String? prefix;

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
  final fullContactNumberController = TextEditingController();
  final otpController = TextEditingController();

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
    fullContactNumberController.clear();
    otpController.clear();
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

        var resp = await AuthApi.register(
          fullname: name,
          email: email,
          password: password,
          contactNo: contactNumber,
          isRecruiter: isRecruiter,
        );

        toggleLoading();

        int statusCode = resp.statusCode;

        if (statusCode == 201) {
          Get.snackbar(
            'Account created successfully!',
            'Login to your account to continue.',
          );

          clearFields();

          Get.offAll(LoginScreen());
        } else {
          Get.snackbar(
            'Error signing up',
            'Failed to register. Please try again later.',
          );
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
        final response = await AuthApi.registerCompany(
            companyName: companyName,
            industryOrSector: industryOrSector,
            companySize: companySize,
            contactNo: contactNo,
            contactEmail: contactEmail,
            street1: street1,
            city: city,
            state: state,
            geolocation: [location.last, location.first],
            country: country,
            postalCode: postalCode,
            id: getId()!);

        if (response.containsKey('error')) {
          Get.snackbar(
            'Error adding company info.',
            response['error'],
          );
          return false;
        } else {
          if (response['success'] == true) {
            Get.snackbar(
              'Verification Completed.',
              'We would take 1-2 days to activate your account.',
            );

            clearFields();
            companyId = response['companyId'];
            return true;
          } else {
            Get.snackbar(
              'Verification Error',
              'Failed. Please try again later.',
            );
            return false;
          }
        }
      } catch (e) {
        Get.snackbar(
          'Verification Error',
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
        if (response.containsKey('error')) {
          Get.snackbar(
            'Login Failed',
            response['error'],
          );
          toggleLoading();
        } else {
          final user = model.User.fromJson(response);
          if (isChecked.value) {
            setLoginStatus(true);
          }
          setToken(user.token);
          setUserType(user.role);
          final fcmToken = await _firebaseMessaging.getToken();
          if (user.role == 'recruiter') {
            setId(user.recruiter!.id);
            final uid = response['recruiter']['user_id'];
            setFCM(fcmToken);
            setUserId(uid);
            await FCMNotificationsApi.registerToken(fcmToken!, uid);
            toggleLoading();
            var status = await AuthApi.getUserStatus(uid);
            print(status);
            if (status == 'accepted') {
              Get.offAll(RecruiterDashboard(recruiter: user.recruiter!));
            } else {
              Get.snackbar(
                'Alert!',
                'Please wait for admin to verify your account',
              );
            }
          } else {
            setId(user.jobseeker!.id);
            final uid = response['jobseeker']['user_id'];
            setFCM(fcmToken);
            setUserId(uid);
            await FCMNotificationsApi.registerToken(fcmToken!, uid);
            toggleLoading();
            Get.offAll(const JobseekerDashboard());
          }
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

  Future<void> resendOTPEmail(String email) async {
    try {
      final response = await AuthApi.forgotPassword(email);
      if (response.containsKey('error')) {
        Get.snackbar(
          'Error',
          response['error'],
        );
      } else {
        Get.snackbar(
          'Success',
          response['message'],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      toggleLoading();
      final response = await AuthApi.verifyToken(otp);
      if (!response) {
        toggleLoading();
        Get.snackbar(
          'Verification Failed.',
          'You provided invalid OTP.',
        );
        return false;
      } else {
        toggleLoading();
        Get.snackbar(
          'Verification successful',
          'Enter your new password to change.',
        );
        return true;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
      return false;
    }
  }

  Future<bool> resetPasswordEmail(String email) async {
    if (resetPasswordFormKey.currentState!.validate()) {
      try {
        toggleLoading();

        final response = await AuthApi.forgotPassword(email);
        if (response.containsKey('error')) {
          toggleLoading();
          Get.back();
          Get.snackbar(
            'Error',
            response['error'],
          );
          return false;
        } else {
          toggleLoading();
          Get.back();
          Get.snackbar(
            'Success',
            response['message'],
          );
          return true;
        }
      } catch (err) {
        toggleLoading();
        Get.back();
        Get.snackbar(
          'Error',
          err.toString(),
        );
        return false;
      }
    }
    return false;
  }

  Future resetPassword(String token, String newPassword) async {
    try {
      toggleLoading();
      final response = await AuthApi.resetPassword(token, newPassword);
      if (response.containsKey('error')) {
        toggleLoading();
        Get.snackbar(
          'Error',
          response['error'],
        );
      } else {
        toggleLoading();
        clearFields();
        Get.offAll(LoginScreen());
        Get.snackbar(
          'Success',
          response['message'],
        );
      }
    } catch (e) {
      toggleLoading();
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  void checkLoginStatus() async {
    toggleLoading();
    final user = getLoginStatus();
    if (user == null || user == false) {
      toggleLoading();
      Get.offAll(LoginScreen());
    } else {
      final type = getUserType();
      if (type == 'recruiter') {
        final response = await AuthApi.getCurrentUser(true, getId()!);
        final recruiter = Recruiter.fromJson(response);
        toggleLoading();
        Get.offAll(RecruiterDashboard(recruiter: recruiter));
      } else {
        toggleLoading();
        Get.offAll(const JobseekerDashboard());
      }
    }
  }

  Future<Company?> getCompanyDetails(String id) async {
    try {
      toggleLoading();
      final company = await CompanyApi.getCompanyInfo(id);
      toggleLoading();
      return company;
    } catch (e) {
      toggleLoading();
      return null;
    }
  }

  void logout() async {
    removeLoginToken();
    removeUserType();
    removeId();
    removeToken();
    setSkipFlag(false);
    await FCMNotificationsApi.removeToken(getFCM()!, getUserId()!);
    removeUserId();
    removeFCM();
  }
}
