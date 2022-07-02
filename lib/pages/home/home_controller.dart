import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getResep() {
    return FirebaseFirestore.instance
        .collection('resep')
        .orderBy("created_at", descending: true)
        .snapshots();
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
    } catch (err) {
      Get.snackbar(
        'Terjadi Kesalahan',
        err.toString(),
      );
    }
    update();
  }
}
