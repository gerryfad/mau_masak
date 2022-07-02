import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CommentController extends GetxController {
  final String postId = Get.arguments['postId'] ?? "";
  final String name = Get.arguments['name'] ?? "";
  final String uid = Get.arguments['uid'] ?? "";
  final String avatar = Get.arguments['avatar'] ?? "";
  final TextEditingController komentar = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getComment() {
    return FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .collection('komentar')
        .snapshots();
  }

  Future<void> postComment(String text) async {
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        FirebaseFirestore.instance
            .collection('resep')
            .doc(postId)
            .collection('komentar')
            .doc(commentId)
            .set({
          'avatar': avatar,
          'username': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        komentar.clear();
      } else {
        Get.snackbar(
          'Terjadi Kesalahan',
          "s",
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
