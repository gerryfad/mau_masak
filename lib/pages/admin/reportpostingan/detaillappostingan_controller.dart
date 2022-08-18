import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class DetailLaporanPostinganController extends GetxController {
  final String laporanId = Get.arguments['laporanId'] ?? "";

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetailLaporan() async {
    return await FirebaseFirestore.instance
        .collection('PelanggaranPostingan')
        .doc(laporanId)
        .get();
  }

  Future<void> suspendAkun(String uid, String postId) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'isDisabled': true});
    await FirebaseFirestore.instance
        .collection('PelanggaranPostingan')
        .doc(laporanId)
        .delete();

    deletepostingan(postId);

    EasyLoading.dismiss();
    Get.back();
  }

  Future<void> deletepostingan(String postId) async {
    await FirebaseFirestore.instance.collection('resep').doc(postId).delete();
  }
}
