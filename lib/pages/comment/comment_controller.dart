import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CommentController extends GetxController {
  final String postId = Get.arguments['postId'] ?? "";
  final String uid = Get.arguments['uid'] ?? "";
  var userData = {};
  final TextEditingController komentar = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    userData = {};
    userData = userInfo.data()!;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getComment() {
    return FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .collection('komentar')
        .snapshots();
  }

  Future<void> postComment(
      String avatar, String username, String uid, String text) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        FirebaseFirestore.instance
            .collection('resep')
            .doc(postId)
            .collection('komentar')
            .doc(commentId)
            .set({
          'avatar': avatar,
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        komentar.clear();
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          "",
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

  Future<void> notifikasiComment(String avatar, String username) async {
    try {
      String activityId = const Uuid().v1();
      FirebaseFirestore.instance
          .collection('activity')
          .doc(uid)
          .collection('activityItems')
          .doc(activityId)
          .set({
        'type': "komentar",
        'profilePhoto': avatar,
        'username': username,
        'uid': uid,
        'postId': postId,
        'created_at': DateTime.now()
      });
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
