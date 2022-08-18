import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DataResepController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getreseps() {
    return FirebaseFirestore.instance.collection('resep').snapshots();
  }

  Future<void> deleteResep(String postId) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));

    await FirebaseFirestore.instance.collection('resep').doc(postId).delete();

    EasyLoading.dismiss();
    Get.back();
    Get.back();
  }
}
