import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/services/firestorage_controller.dart';

class EditProfileController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  //---------------------------
  //Pick Image
  File? images;

  pickImages() async {
    try {
      var image = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (image != null && image.files.isNotEmpty) {
        for (int i = 0; i < image.files.length; i++) {
          images = File(image.files[i].path!);
        }
        update();
        String photoUrl = await FirestorageController()
            .uploadImageToStorage('ProfilePhoto', images ?? File(""), false);
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'profilePhoto': photoUrl,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //---------------------------

  Future<DocumentSnapshot> getUser() async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future<void> updateUser() async {
    EasyLoading.show(status: 'Loading...');
    const Duration(milliseconds: 1000);
    try {
      if (username.value.text == "" && password.value.text == "") {
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'name': username.value.text,
        });
        await FirebaseAuth.instance.currentUser!
            .updatePassword(password.value.text);
      } else if (username.value.text != "") {
        FirebaseFirestore.instance.collection('users').doc(uid).update({
          'name': username.value.text,
        });
      } else {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(password.value.text);
      }

      EasyLoading.dismiss();
      Get.back();
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
        backgroundColor: Colors.red,
      );
      EasyLoading.dismiss();
    }
  }
}
