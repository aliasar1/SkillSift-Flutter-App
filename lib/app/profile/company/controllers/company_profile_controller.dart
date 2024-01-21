import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/firebase.dart';
import '../../../../core/services/place_api.dart';

class CompanyProfileController extends GetxController {
  Rx<bool> isLoading = false.obs;

  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get profilePhoto => _pickedImage.value;

  final Rx<Map<String, dynamic>> _company = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get company => _company.value;

  final Rx<String> _uid = "".obs;

  final Rx<String> _nameRx = "".obs;
  String get companyName => _nameRx.value;

  RxBool isObscure1 = true.obs;
  RxBool isObscure2 = true.obs;
  RxBool isObscure3 = true.obs;

  final updateInfoKey = GlobalKey<FormState>();
  final editPassFormKey = GlobalKey<FormState>();
  final updatePasswordFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final companyIndustryController = TextEditingController();
  final companySizeController = TextEditingController();
  final contactNumberController = TextEditingController();
  final street1Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();

  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final oldPassController = TextEditingController();

  RxList<double> location = <double>[].obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void toggleVisibility1() {
    isObscure1.value = !isObscure1.value;
  }

  void toggleVisibility2() {
    isObscure2.value = !isObscure2.value;
  }

  void toggleVisibility3() {
    isObscure3.value = !isObscure3.value;
  }

  @override
  void onInit() {
    super.onInit();
    updateCompanyId(firebaseAuth.currentUser!.uid);
  }

  updateCompanyId(String uid) {
    _uid.value = uid;
    getCompanyData();
  }

  Future<void> getCompanyData() async {
    try {
      toggleLoading();
      DocumentSnapshot userDoc =
          await firestore.collection('companies').doc(_uid.value).get();
      if (userDoc.exists) {
        _company.value = userDoc.data()! as dynamic;
        update();
      } else {
        print('Company document does not exist.');
      }
    } catch (e) {
      print('Error fetching company data: $e');
    } finally {
      toggleLoading();
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    if (!updatePasswordFormKey.currentState!.validate()) {
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar("Failure", "Password is not matched.");
      return;
    }

    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: oldPassword,
      );

      await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    } catch (error) {
      print("Error validating old password: $error");
      Get.snackbar("Error", "Incorrect old password. Please try again.");
      return;
    }

    try {
      isLoading.value = true;

      await firebaseAuth.currentUser!.updatePassword(newPassword);

      oldPassController.clear();
      passController.clear();
      confirmPassController.clear();

      Get.snackbar("Success", "Password changed successfully");
    } catch (error) {
      print("Error changing password: $error");
      Get.snackbar("Error", "Failed to change password. Please try again.");
    } finally {
      isLoading.value = false;
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

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedImage.value = File(pickedImage!.path);
    String downloadUrl = await _uploadToStorage(_pickedImage.value!);
    await firestore
        .collection('companies')
        .doc(_uid.value)
        .update({'profilePhoto': downloadUrl}).whenComplete(() {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture.');
    });
    update();
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePictures')
        .child('companies')
        .child(_uid.value);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateCompanyDetails() async {
    if (updateInfoKey.currentState!.validate()) {
      try {
        toggleLoading();

        GeoPoint geoPoint;

        if (location.isNotEmpty) {
          geoPoint = GeoPoint(
            location[0],
            location[1],
          );
        } else {
          geoPoint = GeoPoint(
            company['location'].latitude,
            company['location'].longitude,
          );
        }

        await firestore.collection('companies').doc(_uid.value).update({
          'name': nameController.text,
          'industry': companyIndustryController.text,
          'size': companySizeController.text,
          'contactNumber': contactNumberController.text,
          'street': street1Controller.text,
          'city': cityController.text,
          'state': stateController.text,
          'country': countryController.text,
          'postalCode': postalCodeController.text,
          'location': geoPoint,
        });

        _nameRx.value = nameController.text;
        Get.snackbar(
            'Company Details Updated', 'Your details have been updated.');
        Get.back();
      } catch (e) {
        print('Error updating company details: $e');
        Get.snackbar(
            'Error', 'An error occurred while updating company details.');
      } finally {
        toggleLoading();
      }
    }
  }
}
