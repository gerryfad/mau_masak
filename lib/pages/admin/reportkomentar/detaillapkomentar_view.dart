// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/admin/reportkomentar/detaillapkomentar_controller.dart';
import 'package:mau_masak/theme/styles.dart';

class DetailLaporanKomentarView extends StatelessWidget {
  const DetailLaporanKomentarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Detail Laporan",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
          elevation: 0.5,
        ),
        body: GetBuilder<DetailLaporanKomentarController>(
            init: DetailLaporanKomentarController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<DocumentSnapshot>(
                    future: controller.getDetailLaporan(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      var detail = snapshot.data;
                      return Column(
                        children: [
                          Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Container(
                              height: 162,
                              width: Get.width,
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, bottom: 22.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ID Laporan : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Text(
                                            detail?['laporanId'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Pelapor       : ${detail?['pelapor']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Terlapor      : ${detail?['terlapor']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Alasan        : ${detail?['alasan']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Komentar  : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Text(
                                            "\"${detail?['komentar']}\"",
                                            style: TextStyle(color: Colors.red),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GFButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: "Konfirmasi",
                                  middleText: "Apakah Anda Yakin ingin ?",
                                  textConfirm: "Ya",
                                  buttonColor: Colors.red,
                                  confirmTextColor: Colors.white,
                                  cancelTextColor: Colors.black,
                                  onConfirm: () {
                                    controller.suspendAkun(
                                        detail?['terlaporId'],
                                        detail?['postId'],
                                        detail?['commentId']);
                                  },
                                  textCancel: "Tidak",
                                  onCancel: () {});
                            },
                            text: "Banned Akun",
                            shape: GFButtonShape.pills,
                            fullWidthButton: true,
                            color: Colors.red,
                            size: GFSize.LARGE,
                          ),
                        ],
                      );
                    }),
              );
            }));
  }
}
