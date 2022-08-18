// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/admin/reportkomentar/laporankomentar_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

class LaporanKomentarView extends StatelessWidget {
  const LaporanKomentarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Laporan Komentar",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: GetBuilder<LaporanKomentarController>(
          init: LaporanKomentarController(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: controller.getlaporan(),
                  builder: (context, snapshot) {
                    var report = snapshot.data?.docs;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: report?.length ?? 0,
                        itemBuilder: ((context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.info_outline),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pelapor     :  ${report![index]['pelapor']}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Terlapor    :  ${report[index]['terlapor']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              PageName.detaillaporankomentar,
                                              arguments: ({
                                                'laporanId': report[index]
                                                    ['laporanId']
                                              }));
                                        },
                                        child: Text(
                                          "Detail",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }));
                  }),
            );
          }),
    );
  }
}
