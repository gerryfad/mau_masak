import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  String search = "";

  void changeSearch(String value) {
    search = value;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUser() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}
