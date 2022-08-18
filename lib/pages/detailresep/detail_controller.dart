import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final String postId = Get.arguments['postId'];
  final String owneruid = Get.arguments['uid'] ?? "";
  var currentUserData = {};
  var ownerUserData = {};

  @override
  void onInit() {
    getCurrentUser();
    getOwnerUser();

    super.onInit();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetailResep() async {
    return await FirebaseFirestore.instance
        .collection('resep')
        .doc(postId)
        .get();
  }

  Future<void> getOwnerUser() async {
    var userInfo = (await FirebaseFirestore.instance
        .collection('users')
        .doc(owneruid)
        .get());
    ownerUserData = {};
    ownerUserData = userInfo.data()!;
    update();
  }

  Future<void> getCurrentUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    currentUserData = {};
    currentUserData = userInfo.data()!;
    update();
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
      );
    }
    update();
  }

  Future<void> dislikePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'dislikes': FieldValue.arrayRemove([uid])
        });
      } else {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'dislikes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      Get.snackbar(
        'Terjadi Kesalahan',
        error.toString(),
      );
    }
    update();
  }
}
