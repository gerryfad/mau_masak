import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mau_masak/model/resep.dart';

class DetailController extends GetxController {
  final String postId = Get.arguments['postId'];

  // @override
  // void onReady() {
  //   getDetailResep(postId);
  //   super.onReady();
  // }

  Future<Resep?> getDetailResep() async {
    final dataResep =
        await FirebaseFirestore.instance.collection('resep').doc(postId).get();

    if (dataResep.exists) {
      return Resep.fromJson(dataResep.data()!);
    }
  }
}
