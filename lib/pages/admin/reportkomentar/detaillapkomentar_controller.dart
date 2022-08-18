import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class DetailLaporanKomentarController extends GetxController {
  final String laporanId = Get.arguments['laporanId'] ?? "";

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetailLaporan() async {
    return await FirebaseFirestore.instance
        .collection('PelanggaranKomentar')
        .doc(laporanId)
        .get();
  }

  Future<void> suspendAkun(String uid, String postId, String commentId) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'isDisabled': true});
    await FirebaseFirestore.instance
        .collection('PelanggaranKomentar')
        .doc(laporanId)
        .delete();

    deletekomentar(postId, commentId);

    EasyLoading.dismiss();
    Get.back();
    Get.back();
  }

  Future<void> deletekomentar(String postId, String commentId) async {
    await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .collection('komentar')
        .doc(commentId)
        .delete();
  }
}
