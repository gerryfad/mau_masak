import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/user.dart' as model;

class AuthController extends GetxController {
  var firebaseAuth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  static AuthController instance = Get.find();

  Stream<User?> streamAuthStatus() {
    return firebaseAuth.authStateChanges();
  }

  //Register User
  void registerUser(String username, String email, String password) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        EasyLoading.dismiss();
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }
}
