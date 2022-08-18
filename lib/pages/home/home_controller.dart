import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/services/local_push_notification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  List resepDatas = [];
  var currentUserData = {};
  final RefreshController homeRefreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    getresepfeed();
    getResepUser();
    homeRefreshController.refreshCompleted();
  }

  @override
  void onInit() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    getresepfeed();
    getResepUser();
    getCurrentUser();

    super.onInit();
  }

  Future<void> getCurrentUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        (await FirebaseFirestore.instance.collection('users').doc(uid).get());
    currentUserData = {};
    currentUserData = userInfo.data()!;
    update();
  }

  Future<int> getcommentlength(String postid) async {
    int commentlength = ((await FirebaseFirestore.instance
                .collection('resep')
                .doc(postid)
                .collection('komentar')
                .get())
            .docs)
        .length;
    print(commentlength);
    return commentlength;
  }

  Future<void> getresepfeed() async {
    resepDatas = [];
    DocumentSnapshot userInfo = (await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get());

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

  Future<void> deleteResep(String postId) async {
    await FirebaseFirestore.instance.collection('resep').doc(postId).delete();
    Get.offAllNamed(PageName.dashboard);
  }

  Future<void> addview(String postId, int views) async {
    await FirebaseFirestore.instance.collection('resep').doc(postId).update({
      'views': (views + 1),
    });
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    EasyLoading.show(status: 'Loading...');

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
    getresepfeed();
    getResepUser();
    await Future.delayed(Duration(milliseconds: 500));
    EasyLoading.dismiss();
    update();
  }
}
