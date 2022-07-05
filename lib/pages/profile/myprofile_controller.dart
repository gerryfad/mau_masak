import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfileController extends GetxController {
  var userData = {};
  var resepData = [];

  final RefreshController myProfileRefreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    getResepUser();
    super.onInit();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    getUser();
    getResepUser();
    myProfileRefreshController.refreshCompleted();
  }

  Future<void> getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    userData = {};
    userData = userInfo.data()!;
    update();
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
}
