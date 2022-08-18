import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

class CommentController extends GetxController {
  final String postId = Get.arguments['postId'] ?? "";
  final String uid = Get.arguments['uid'] ?? "";
  var currentUserData = {};
  var ownerUserData = {};
  final TextEditingController komentar = TextEditingController();

  @override
  void onInit() {
    getCurrentUser();
    getOwnerUser();

    super.onInit();
  }

  Future<void> getOwnerUser() async {
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    ownerUserData = {};
    ownerUserData = userInfo.data()!;
    update();
  }

  Future<void> getCurrentUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    currentUserData = {};
    currentUserData = userInfo.data()!;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getComment() {
    return FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .collection('komentar')
        .orderBy('created_at', descending: false)
        .snapshots();
  }

  Future<void> postComment(
      String profilePhoto, String username, String uid) async {
    var resepInfo = (await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .get());
    try {
      if (komentar.value.text != "") {
        String commentId = const Uuid().v1();
        await FirebaseFirestore.instance
            .collection('resep')
            .doc(postId)
            .collection('komentar')
            .doc(commentId)
            .set({
          'profile_photo': profilePhoto,
          'username': username,
          'uid': uid,
          'text': komentar.value.text,
          'commentId': commentId,
          'created_at': DateTime.now(),
        });
        komentar.clear();
        await FirebaseFirestore.instance
            .collection('resep')
            .doc(postId)
            .update({'jumlahkomentar': (resepInfo['jumlahkomentar'] + 1)});
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          "Silahkan isi komentar terlebih dahulu",
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
