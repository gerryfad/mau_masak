import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DataUsersController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getusers() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  Future<void> suspendAkun(String uid) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'isDisabled': true});

    EasyLoading.dismiss();
    Get.back();
    Get.back();
  }
}
