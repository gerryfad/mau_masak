import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/resep.dart';

class DetailController extends GetxController {
  final String postId = Get.arguments['postId'];
  bool likeColor = false;

  Future<Resep?> getDetailResep() async {
    final dataResep =
        await FirebaseFirestore.instance.collection('resep').doc(postId).get();

    if (dataResep.exists) {
      return Resep.fromJson(dataResep.data()!);
    }
    return null;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        likeColor = false;
      } else {
        FirebaseFirestore.instance.collection('resep').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        likeColor = true;
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
