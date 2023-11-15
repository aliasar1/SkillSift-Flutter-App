import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
// import 'package:image_picker/image_picker.dart';

import '../../../../core/exports/constants_exports.dart';

class ProfileController extends GetxController with CacheManager {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get profilePhoto => _pickedImage.value;

  final Rx<String> _uid = "".obs;
  Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    toggleLoading();
    updateUserId(firebaseAuth.currentUser!.uid);
    getUserData();
    toggleLoading();
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  void getUserData() async {
    final type = getUserType();

    DocumentSnapshot userDoc =
        await firestore.collection(type!).doc(_uid.value).get();
    _user.value = userDoc.data()! as dynamic;
    update();
  }

  // void pickImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   _pickedImage.value = File(pickedImage!.path);
  //   String downloadUrl = await _uploadToStorage(_pickedImage.value!);
  //   await firestore
  //       .collection('users')
  //       .doc(_uid.value)
  //       .update({'profilePhoto': downloadUrl}).whenComplete(() {
  //     Get.snackbar('Profile Picture',
  //         'You have successfully selected your profile picture.');
  //   });
  //   update();
  // }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
