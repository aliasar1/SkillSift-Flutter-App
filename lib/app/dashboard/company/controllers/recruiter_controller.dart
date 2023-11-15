import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';

import '../../../../core/models/recruiter_model.dart';

class RecruiterController extends GetxController {
  final addFormKey = GlobalKey<FormState>();

  RxList<Recruiter> recruiters = <Recruiter>[].obs;
  Rx<bool> isLoading = false.obs;

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();

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

    firestore.collection('recruiters').get().then((querySnapshot) {
      final List<Recruiter> allRecruiters = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Recruiter.fromJson(data);
      }).toList();

      recruiters.value = allRecruiters
          .where((recruiter) => recruiter.companyId == userCredCompanyId)
          .toList();

      isLoading.value = false;
    }).catchError((error) {
      print('Error fetching recruiters: $error');
      isLoading.value = false;
    });
  }

  void addRecruiter(
      String name, String empId, String role, String email) async {
    if (addFormKey.currentState!.validate()) {
      try {
        toggleLoading();
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: 'Company123@',
        );

        String uid = userCredential.user!.uid;
        // print('here');
        // await firestore.collection('users').doc(uid).set({
        //   'uid': uid,
        //   'email': email,
        //   'type': 'recruiters',
        //   'verificationStatus': 'pending',
        //   'verifiedBy': '',
        // });
        // print('here2');

        final recruiter = Recruiter(
          fullName: name,
          email: email,
          uid: uid,
          companyId: firebaseAuth.currentUser!.uid,
          employeeId: empId,
          profilePhoto: '',
          phone: '',
          role: role,
          isPassChanged: false,
        );

        // Step 4: Add the Recruiter to Firestore
        await firestore
            .collection('recruiters')
            .doc(uid)
            .set(recruiter.toJson());

        recruiters.add(recruiter);
        print('Recruiter added successfully');
        Get.back();
      } catch (error) {
        print('Error adding recruiter: $error');
      } finally {
        toggleLoading();
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
