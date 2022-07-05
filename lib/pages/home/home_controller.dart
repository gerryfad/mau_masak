import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List resepDatas = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> getResep() {
    return FirebaseFirestore.instance
        .collection('resep')
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getresepfeed();
    getResepUser();
    super.onInit();
  }

  Future<void> getresepfeed() async {
    DocumentSnapshot userInfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    for (var i = 0; i < userInfo['following'].length; i++) {
      resepDatas.addAll((await FirebaseFirestore.instance
              .collection('resep')
              .where('uid', isEqualTo: userInfo['following'][i])
              .get())
          .docs);
    }
    resepDatas.sort((b, a) => a["created_at"].compareTo(b["created_at"]));
    update();
  }

  Future<void> getResepUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    resepDatas.addAll((await FirebaseFirestore.instance
            .collection('resep')
            .where('uid', isEqualTo: uid)
            .get())
        .docs);
    resepDatas.sort((b, a) => a["created_at"].compareTo(b["created_at"]));
    update();
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        resepDatas = [];
        getresepfeed();
        getResepUser();
      } else {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        resepDatas = [];
        getresepfeed();
        getResepUser();
      }
    } catch (err) {
      Get.snackbar(
        'Terjadi Kesalahan',
        err.toString(),
      );
    }

    update();
  }
}
