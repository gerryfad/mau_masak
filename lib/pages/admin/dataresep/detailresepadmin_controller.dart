import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DetailResepAdminController extends GetxController {
  final String postId = Get.arguments['postId'];

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetailResep() async {
    return await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .get();
  }
}
