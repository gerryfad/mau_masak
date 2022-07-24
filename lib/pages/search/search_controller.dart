import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  String search = "";

  TextEditingController searchc = TextEditingController();

  bool togglesearch = true;

  void changeToggleSearch(bool value) {
    togglesearch = value;
    update();
  }

  void changeSearch(String value) {
    search = value;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUser() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getResep() {
    return FirebaseFirestore.instance.collection("resep").snapshots();
  }
}
