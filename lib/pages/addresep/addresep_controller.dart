import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/resep.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/services/fireStorage_controller.dart';
import 'package:uuid/uuid.dart';

class AddresepController extends GetxController {
  final GlobalKey<FormBuilderState> formKeyAddResep =
      GlobalKey<FormBuilderState>();

  Resep resepModel = Resep();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //---------------------------
  //Form Bahan
  int inputBahan = 1;
  List<String> bahan = [];

  void addInputBahan() {
    inputBahan++;
    update();
  }

  void removeInputBahan() {
    inputBahan--;
    update();
  }

  //---------------------------
  //Form Langkah
  int inputLangkah = 1;
  List<String> langkah = [];

  void addInputLangkah() {
    inputLangkah++;
    update();
  }

  void removeInputLangkah() {
    inputLangkah--;
    update();
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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteImage() {
    images = null;
    update();
  }

  //---------------------------
  //Post Resep

  void postResep(String deskripsi, String namaResep, int waktu) async {
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot userInfo =
        await firestore.collection('users').doc(uid).get();
    EasyLoading.show(status: 'Loading...');
    try {
      await uploadPost(deskripsi, namaResep, waktu, images ?? File(''), uid,
          (userInfo.data()! as Map<String, dynamic>)['name'], "avatar");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> uploadPost(String deskripsi, String namaResep, int waktu,
      File file, String uid, String username, String avatar) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management

    try {
      String photoUrl = await FirestorageController()
          .uploadImageToStorage('fotoResep', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Resep resep = Resep(
        avatar: avatar,
        username: username,
        likes: [],
        uid: uid,
        postId: postId,
        createdAt: DateTime.now(),
        namaResep: namaResep,
        fotoResep: photoUrl,
        deskripsi: deskripsi,
        waktu: waktu,
        bahan: bahan,
        step: langkah,
      );

      firestore.collection('resep').doc(postId).set(resep.toJson());
      EasyLoading.dismiss();

      Get.snackbar('Succes', "Berhasil Membuat Resep",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent);

      Get.offAllNamed(PageName.dashboard);
    } catch (err) {
      Get.snackbar(
        'Error Creating Account',
        err.toString(),
      );
    }
  }
}
