import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ReportController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final String postId = Get.arguments['postId'] ?? "";
  final String commentId = Get.arguments['commentId'] ?? "";
  final String pelanggaran = Get.arguments['pelanggaran'] ?? "";
  final String terlapor = Get.arguments['terlapor'] ?? "";
  final String pelapor = Get.arguments['pelapor'] ?? "";
  final String type = Get.arguments['type'] ?? "";
  final String terlaporId = Get.arguments['terlaporId'] ?? "";

  Future<void> postLaporanKomentar(String alasan) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));
    String laporanId = const Uuid().v1();
    try {
      await FirebaseFirestore.instance
          .collection('PelanggaranKomentar')
          .doc(laporanId)
          .set({
        'laporanId': laporanId,
        'commentId': commentId,
        'postId': postId,
        'terlaporId': terlaporId,
        'terlapor': terlapor,
        'pelapor': pelapor,
        'alasan': alasan,
        'komentar': pelanggaran
      });
      EasyLoading.dismiss();
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      Get.back();
    }
  }

  Future<void> postLaporanPostingan(String alasan) async {
    EasyLoading.show(status: 'Loading...');
    await Future.delayed(const Duration(milliseconds: 1000));
    String laporanId = const Uuid().v1();
    try {
      await FirebaseFirestore.instance
          .collection('PelanggaranPostingan')
          .doc(laporanId)
          .set({
        'laporanId': laporanId,
        'postId': postId,
        'terlaporId': terlaporId,
        'terlapor': terlapor,
        'pelapor': pelapor,
        'alasan': alasan,
        'content': pelanggaran
      });
      EasyLoading.dismiss();
      Get.back();
    } catch (error) {
      EasyLoading.dismiss();
      print(error);
      Get.back();
    }
  }
}
