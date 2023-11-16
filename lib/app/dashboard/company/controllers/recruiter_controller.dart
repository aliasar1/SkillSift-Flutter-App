import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';

import '../../../../core/models/recruiter_model.dart';

class RecruiterController extends GetxController with CacheManager {
  final addFormKey = GlobalKey<FormState>();

  RxList<Recruiter> recruiters = <Recruiter>[].obs;
  Rx<bool> isLoading = false.obs;

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();

  void clearFields() {
    nameController.clear();
    roleController.clear();
    emailController.clear();
    employeeIdController.clear();
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecruiters(firebaseAuth.currentUser!.uid);
  }

  void fetchRecruiters(String userCredCompanyId) {
    isLoading.value = true;

    firestore
        .collection('recruiters')
        .where('companyId', isEqualTo: userCredCompanyId)
        .get()
        .then((querySnapshot) {
      final List<Recruiter> allRecruiters = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Recruiter.fromJson(data);
      }).toList();

      recruiters.value = allRecruiters;
    }).catchError((error) {
      Get.snackbar(
        'Failed!',
        'An error has occured: $error',
      );
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void addRecruiter(String name, String empId, String role, String email,
      String companyId) async {
    if (addFormKey.currentState!.validate()) {
      try {
        toggleLoading();

        // Create a new user
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: 'Company123@',
        );

        String uid = userCredential.user!.uid;

        // Set additional user data in Firestore
        await firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'type': 'recruiters',
          'verificationStatus': 'pending',
          'verifiedBy': '',
        });

        final recruiter = Recruiter(
          fullName: name,
          email: email,
          uid: uid,
          companyId: companyId,
          employeeId: empId,
          profilePhoto: '',
          phone: '',
          role: role,
          isPassChanged: false,
        );

        // Add the Recruiter to Firestore
        await firestore
            .collection('recruiters')
            .doc(uid)
            .set(recruiter.toJson());

        recruiters.add(recruiter);

        // Sign out the current user
        await firebaseAuth.signOut();

        // Sign in the new user
        await firebaseAuth.signInWithEmailAndPassword(
          email: getEmail()!,
          password: getPass()!,
        );

        toggleLoading();
        Get.back();
        clearFields();
        Get.snackbar(
          'Success!',
          'Recruiter added successfully.',
        );
      } catch (error) {
        toggleLoading();
        Get.snackbar(
          'Failed!',
          'An error has occured: $error',
        );
      }
    }
  }

  String generateRandomPassword() {
    const String validCharacters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';

    final Random random = Random();
    const int passwordLength = 8;

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < passwordLength; i++) {
      buffer.write(validCharacters[random.nextInt(validCharacters.length)]);
    }

    return buffer.toString();
  }
}
