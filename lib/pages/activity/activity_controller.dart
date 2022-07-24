import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  Stream<QuerySnapshot<Map<String, dynamic>>> getActivity() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('activity')
        .doc(uid)
        .collection('activityItems')
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
