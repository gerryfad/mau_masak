import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController {
  var userData = {};
  var resepData = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    getResepUser();
    super.onInit();
  }

  Future<void> getUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
       ( await FirebaseFirestore.instance.collection('users').doc(uid).get());
    userData = userInfo.data()!;
    update();
  }

  void getResepUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var resep = await FirebaseFirestore.instance
        .collection('resep')
        .where('uid', isEqualTo: uid)
        .get();
    resepData = resep.docs;
    update();
  }
}
