import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mau_masak/services/firemessaging_controller.dart';

class UserProfileController extends GetxController {
  final String uid = Get.arguments['uid'] ?? "";
  var resepData = [];
  bool isloading = true;
  bool isFollowing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    getResepUser();
    super.onInit();
  }

  Future<DocumentSnapshot> getUserFuture() async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
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
      List following = snap['following'];

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
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
