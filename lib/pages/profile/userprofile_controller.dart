import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final String uid = Get.arguments['uid'] ?? "";
  var userData = {};
  var resepData = [];
  bool isloading = true;
  bool isFollowing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    getResepUser();
    super.onInit();
  }

  Future<void> getUser() async {
    var userInfo =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    userData = userInfo.data() ?? {};
    update();
  }

  void getResepUser() async {
    var resep = await FirebaseFirestore.instance
        .collection('resep')
        .where('uid', isEqualTo: uid)
        .get();
    resepData = resep.docs;
    isloading = false;
    update();
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(followId)
            .update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
      getUser();
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
