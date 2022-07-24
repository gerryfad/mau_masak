import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.show(status: 'loading...');

      if (firebaseAuth.currentUser!.emailVerified) {
        EasyLoading.showSuccess('Great Success!',
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
        Get.snackbar('Error', 'Email Belum Terdaftar');
      } else if (e.code == 'wrong-password') {
        EasyLoading.dismiss();
        Get.snackbar('Error', 'Password Salah !');
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
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message!); // Displaying the error message
    }
  }
}
