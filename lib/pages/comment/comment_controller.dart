import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/services/local_push_notification.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
  final String postId = Get.arguments['postId'] ?? "";
  final String uid = Get.arguments['uid'] ?? "";
  var currentUserData = {};
  var ownerUserData = {};
  final TextEditingController komentar = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
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
        .orderBy('datePublished', descending: false)
        .snapshots();
  }

  void postKomentar(String avatar, String username, String uid) async {
    Get.snackbar(
      'Terjadi Kesalahan',
      "Silahkan isi komentar terlebih dahulu",
      backgroundColor: Colors.green,
    );
    String commentId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .collection('komentar')
        .doc(commentId)
        .set({
      'avatar': avatar,
      'username': username,
      'uid': uid,
      'text': komentar.value.text,
      'commentId': commentId,
      'datePublished': DateTime.now(),
    });
    komentar.clear();
  }

  Future<void> postComment(String avatar, String username, String uid) async {
    try {
      if (komentar.value.text != "") {
        String commentId = const Uuid().v1();
        await FirebaseFirestore.instance
            .collection('resep')
            .doc(postId)
            .collection('komentar')
            .doc(commentId)
            .set({
          'avatar': avatar,
          'username': username,
          'uid': uid,
          'text': komentar.value.text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        komentar.clear();
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
