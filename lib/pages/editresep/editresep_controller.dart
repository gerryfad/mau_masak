import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/resep.dart';
import 'package:mau_masak/model/user.dart' as model;
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/services/fireStorage_controller.dart';
import 'package:uuid/uuid.dart';

class EditResepController extends GetxController {
  final GlobalKey<FormBuilderState> formKeyAddResep =
      GlobalKey<FormBuilderState>();
  final String postId = Get.arguments['postId'];
  var dataresep = {};
  TextEditingController langkahtext = TextEditingController();
  TextEditingController bahantext = TextEditingController();
  bool isLoading = true;
  List cobainit = ['waw', 'wew'];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() async {
    getresep();

    super.onInit();
  }

  Future<void> getresep() async {
    var resepinfo = (await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .get());
    dataresep = resepinfo.data()!;
    inputBahan = dataresep['bahan'].length ?? 0;
    inputLangkah = dataresep['step'].length ?? 0;

    await Future.delayed(Duration(milliseconds: 1000));
    isLoading = false;
    update();
  }

  //---------------------------
  //Form Bahan
  int inputBahan = 1;
  int inputBahantambah = 0;
  List<String> bahan = [];

  void addInputBahan() {
    inputBahantambah++;
    update();
  }

  void removeInputBahantambah() {
    inputBahantambah--;
    update();
  }

  void removeInputBahan() {
    inputBahan--;
    update();
  }

  //---------------------------
  //Form Langkah
  int inputLangkah = 1;
  int inputLangkahtambah = 0;
  List<String> langkah = [];

  void addInputLangkah() {
    inputLangkahtambah++;
    update();
  }

  void removeInputLangkah() {
    inputLangkahtambah--;
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

  Future<void> editPost(String deskripsi, String namaResep, int waktu,
      DateTime createdat, var likes, var dislikes) async {
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot userInfo =
        await (firestore.collection('users').doc(uid).get());
    model.User user = model.User.fromJson(userInfo);
    EasyLoading.show(status: 'Loading...');
    try {
      String photoUrl = images != null
          ? await FirestorageController()
              .uploadImageToStorage('fotoResep', images ?? File(""), true)
          : dataresep['foto_resep'];

      Resep resep = Resep(
        profilePhoto: user.profilePhoto,
        username: user.username,
        likes: likes,
        uid: user.uid,
        postId: postId,
        createdAt: createdat,
        namaResep: namaResep,
        fotoResep: photoUrl,
        deskripsi: deskripsi,
        dislikes: dislikes,
        waktu: waktu,
        bahan: bahan,
        step: langkah,
      );

      firestore.collection('resep').doc(postId).update(resep.toJson());

      EasyLoading.dismiss();

      Get.snackbar('Success', "Berhasil Edit Resep",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent);

      Get.offAllNamed(PageName.dashboard);
    } catch (err) {
      Get.snackbar('Terjadi Kesalahan', err.toString(),
          backgroundColor: Colors.red);
      EasyLoading.dismiss();
    }
  }
}
