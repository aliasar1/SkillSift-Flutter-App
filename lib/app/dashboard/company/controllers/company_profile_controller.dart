import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/exports/constants_exports.dart';
import '../../../../core/local/cache_manager.dart';

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

    updateUserId(firebaseAuth.currentUser!.uid);
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  updateUserId(String uid) {
    isLoading.value = true;
    _uid.value = uid;
    getUserData();
  }

  Future<void> getUserData() async {
    final type = getUserType();

    if (type == 'companies') {
      DocumentSnapshot userDoc =
          await firestore.collection(type!).doc(_uid.value).get();
      _user.value = userDoc.data()! as dynamic;
    } else if (type == 'recruiters') {
      DocumentSnapshot userDoc = await firestore
          .collection('companies')
          .doc(getCompanyId())
          .collection('recruiters')
          .doc(_uid.value)
          .get();
      print(userDoc.data()! as dynamic);
      _user.value = userDoc.data()! as dynamic;
    }
    isLoading.value = false;
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _pickedImage.value = File(pickedImage!.path);
    String downloadUrl = await _uploadToStorage(_pickedImage.value!);
    await firestore
        .collection('users')
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
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
