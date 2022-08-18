// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mau_masak/pages/home/home_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MauMasak",
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return SmartRefresher(
              controller: controller.homeRefreshController,
              onRefresh: controller.onRefresh,
              child: controller.resepDatas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add_sharp,
                            color: Colors.grey,
                            size: 100,
                          ),
                          Text(
                            "Anda Belum Mengikuti\nPengguna Manapun",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: List.generate(
                                  controller.resepDatas.length, (index) {
                                return ResepCard(
                                  controller: controller,
                                  resepData: controller.resepDatas[index],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}

class ResepCard extends StatelessWidget {
  ResepCard({required this.resepData, required this.controller});
  final HomeController controller;
  var resepData;

  @override
  Widget build(BuildContext context) {
    // var comment = await controller.getcommentlength(resepData['postId']);
    // print(comment);
    return GestureDetector(
      onTap: (() {
        controller.addview(resepData['postId'], resepData['views']);
        Get.toNamed(
          PageName.detail,
          arguments: {
            "postId": resepData['postId'],
            "uid": resepData['uid'],
          },
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE5E5E5).withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----------------------------------------------------------------------
              //User Info
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              NetworkImage(resepData["profile_photo"]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(PageName.userprofile, arguments: {
                                  "uid": resepData['uid'],
                                });
                              },
                              child: Text(
                                resepData['username'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(resepData['created_at'].toDate()),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: Get.width * 0.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .deleteResep(resepData["postId"]);
                                        },
                                        child: Container(
                                          width: 290,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text("Hapus Postingan"),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                          Get.toNamed(PageName.laporpengguna,
                                              arguments: ({
                                                'postId': resepData["postId"],
                                                'commentId': '',
                                                'terlapor':
                                                    resepData["username"],
                                                'terlaporId': resepData["uid"],
                                                'pelapor': controller
                                                    .currentUserData['name'],
                                                'pelanggaran':
                                                    resepData["foto_resep"],
                                                'type': 'postingan'
                                              }));
                                        },
                                        child: Container(
                                          width: 290,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text("Lapor Postingan"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
              //----------------------------------------------------------------------
              SizedBox(
                height: 10,
              ),
              //----------------------------------------------------------------------
              //Resep Info
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 288,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 1))
                        ],
                        image: DecorationImage(
                            image: NetworkImage(resepData['foto_resep']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Container(
                      width: double.infinity,
                      height: 288,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.25))),
                  Container(
                    width: double.infinity,
                    height: 288,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(27),
                                            color:
                                                primaryColor.withOpacity(0.5)),
                                        child: Text(
                                          resepData['nama_resep'],
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(27),
                                            color:
                                                primaryColor.withOpacity(0.5)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.alarm,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "${resepData['waktu'].toString()} menit",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(27),
                                            color:
                                                primaryColor.withOpacity(0.5)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.remove_red_eye_sharp,
                                              color: Colors.white,
                                              size: 17,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              resepData['views'].toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.likePost(
                                      resepData['postId'],
                                      controller.currentUserData['uid'],
                                      resepData['likes']);
                                },
                                child: Container(
                                  width: 70,
                                  height: 37,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: primaryColor.withOpacity(0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: (resepData['likes']).contains(
                                                controller
                                                    .currentUserData['uid'])
                                            ? Colors.red
                                            : Colors.white,
                                        size: 18,
                                      ),
                                      Text(
                                        resepData['likes'].length.toString(),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(PageName.comment, arguments: {
                                    "postId": resepData['postId'],
                                    "uid": resepData['uid']
                                  });
                                },
                                child: Container(
                                  height: 37,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      color: primaryColor.withOpacity(0.5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.message_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        resepData['jumlahkomentar'].toString(),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //----------------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
