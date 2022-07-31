import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/user.dart' as model;
import 'package:mau_masak/routes/page_names.dart';

class AuthController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  static AuthController instance = Get.find();

  Stream<User?> streamAuthStatus() {
    return firebaseAuth.authStateChanges();
  }

  //Login User
  void loginUser(String email, String password) async {
    String? token = await FirebaseMessaging.instance.getToken();
    EasyLoading.show(status: 'loading...');
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (firebaseAuth.currentUser!.emailVerified) {
        EasyLoading.showSuccess('Berhasil!',
            duration: const Duration(milliseconds: 500));
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .set({'tokenNotif': token}, SetOptions(merge: true));
        Get.offAllNamed(PageName.dashboard);
      } else {
        EasyLoading.dismiss();
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Silahkan Verifikasi Email Terlebih Dahulu",
            onConfirm: () {
              Get.back();
            },
            textConfirm: "Keluar");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.dismiss();
        Get.snackbar('Terjadi Kesalahan', 'Email Belum Terdaftar',
            backgroundColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        EasyLoading.dismiss();
        Get.snackbar('Terjadi Kesalahan', 'Password Salah !',
            backgroundColor: Colors.red);
      }
    }
  }

  //Register User
  void registerUser(String username, String email, String password) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential akun = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        firebaseAuth.currentUser!.sendEmailVerification();
        model.User user = model.User(
            username: username,
            email: email,
            uid: akun.user!.uid,
            followers: [],
            following: [],
            profilePhoto:
                "https://firebasestorage.googleapis.com/v0/b/maumasak-ta.appspot.com/o/defaultphoto.jpeg?alt=media&token=dbc86119-76ec-4690-a0a5-e8c277d6aa06");
        await firestore
            .collection('users')
            .doc(akun.user!.uid)
            .set(user.toJson());
        EasyLoading.dismiss();
        Get.defaultDialog(
            title: "Verifikasi Email",
            middleText: "MauMasak Telah Mengirimkan Verifikasi Email",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "Keluar");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Terjadi Kesalahan',
        e.toString(),
      );
    }
  }
}
