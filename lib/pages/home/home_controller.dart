import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getResep() {
    return FirebaseFirestore.instance
        .collection('resep')
        .orderBy("created_at", descending: true)
        .snapshots();
  }
}
