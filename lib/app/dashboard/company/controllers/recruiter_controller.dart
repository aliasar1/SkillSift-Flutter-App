import 'dart:convert';

import 'package:emailjs/emailjs.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/constants/firebase.dart';
import 'package:skillsift_flutter_app/core/constants/strings.dart';
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
        .collection('companies')
        .doc(firebaseAuth.currentUser!.uid)
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
        String pass = 'Company123@';

        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

        AppStrings.RECRUITER_EMAIL = email;
        AppStrings.RECRUITER_PASS = pass;

        await sendEmail(
            name: name,
            email: email,
            subject: 'Login Credentials',
            message: AppStrings.EMAIL_MESSAGE);

        String uid = userCredential.user!.uid;

        await firestore.collection('users').doc(uid).set({
          'uid': uid,
          'email': email,
          'type': 'recruiters',
          'verificationStatus': 'approved',
          'verifiedBy': '',
        });

        final recruiter = Recruiter(
          fullName: name,
          email: email,
          pass: {pass: pass, pass: pass},
          uid: uid,
          companyId: companyId,
          employeeId: empId,
          profilePhoto: '',
          phone: '',
          role: role,
          isPassChanged: false,
        );

        await firestore
            .collection('companies')
            .doc(companyId)
            .collection('recruiters')
            .doc(uid)
            .set(recruiter.toJson());

        recruiters.add(recruiter);

        await firebaseAuth.signOut();

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

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_yorfij8';
    const templateId = 'template_yor8hww';
    const publicKey = '_CPqXppcqY0pkxL3U';
    const privateKey = 'XMJDjNBzyrHk6CRpaustS';

    Map<String, dynamic> templateParams = {
      'user_name': name,
      'email_to': email,
      'user_email': email,
      'user_subject': subject,
      'user_message': message,
    };

    try {
      await EmailJS.send(
        serviceId,
        templateId,
        templateParams,
        const Options(
          publicKey: publicKey,
          privateKey: privateKey,
        ),
      );
    } catch (error) {
      Get.snackbar(
        'Failed to send email!',
        'An error has occured: $error',
      );
    }
  }

  void updateRecruiter(
      String recruiterId, String newName, String newRole) async {
    if (addFormKey.currentState!.validate()) {
      addFormKey.currentState!.save();
      try {
        toggleLoading();
        await firestore
            .collection('companies')
            .doc(firebaseAuth.currentUser!.uid)
            .collection('recruiters')
            .doc(recruiterId)
            .update({
          'fullName': newName,
          'role': newRole,
        });

        final updatedRecruiter =
            recruiters.firstWhere((r) => r.uid == recruiterId);
        updatedRecruiter.fullName = newName;
        updatedRecruiter.role = newRole;

        toggleLoading();
        Get.back();
        clearFields();
        Get.snackbar(
          'Success!',
          'Recruiter updated successfully.',
        );
      } catch (error) {
        toggleLoading();
        Get.snackbar(
          'Failed!',
          'An error has occurred: $error',
        );
      }
    }
  }

  void deleteRecruiter(Recruiter recruiter) async {
    try {
      await firestore
          .collection('companies')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('recruiters')
          .doc(recruiter.uid)
          .delete();

      await firebaseAuth.signInWithEmailAndPassword(
          email: recruiter.email, password: 'Company123@');
      await firebaseAuth.currentUser!.delete();

      await firebaseAuth.signOut();

      await firebaseAuth.signInWithEmailAndPassword(
        email: getEmail()!,
        password: getPass()!,
      );

      await firestore.collection('users').doc(recruiter.uid).delete();

      recruiters.removeWhere((r) => r.uid == recruiter.uid);

      Get.snackbar(
        'Success!',
        'Recruiter deleted successfully.',
      );
    } catch (error) {
      Get.snackbar(
        'Failed!',
        'An error has occurred: $error',
      );
    }
  }
}
