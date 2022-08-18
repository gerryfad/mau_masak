import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LaporanPostinganController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getlaporan() {
    return FirebaseFirestore.instance
        .collection('PelanggaranPostingan')
        .snapshots();
  }
}
