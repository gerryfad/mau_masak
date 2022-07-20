import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/theme/styles.dart';

class ResetPasswordController extends GetxController {
  TextEditingController email = TextEditingController();

  void resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: "Berhasil",
          middleText:
              "MauMasak Telah Mengirimkan Reset Password ke email $email",
          confirmTextColor: Colors.white,
          buttonColor: primaryColor,
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Close");
    } catch (error) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Email Tidak Terdaftar",
          confirmTextColor: Colors.white,
          buttonColor: primaryColor,
          onConfirm: () {
            Get.back();
          },
          textConfirm: "Close");
    }
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
