import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/services/local_push_notification.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  List resepDatas = [];
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

    super.onInit();
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
}
