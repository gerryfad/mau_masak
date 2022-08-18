import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfileController extends GetxController {
  var userData = {};
  var resepData = [];
  TextEditingController editbio = TextEditingController();
  final RefreshController myProfileRefreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    getResepUser();
    super.onInit();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    getResepUser();
    myProfileRefreshController.refreshCompleted();
  }

  Future<DocumentSnapshot> getUserFuture() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future<void> editbios() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    EasyLoading.show(status: 'loading...');
    await Future.delayed(const Duration(milliseconds: 500));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'bio': editbio.value.text});
    EasyLoading.dismiss();
    Get.back();
  }

  void getResepUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var resep = await FirebaseFirestore.instance
        .collection('resep')
        .where('uid', isEqualTo: uid)
        .get();
    resepData = [];
    resepData = resep.docs;
    resepData.sort((b, a) => a["created_at"].compareTo(b["created_at"]));
    update();
  }

  void logout() async {
    EasyLoading.show(status: 'loading...');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(PageName.login);
    EasyLoading.dismiss();
  }
}
