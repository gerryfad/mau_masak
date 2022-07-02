// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/detailresep/detail_controller.dart';
import 'package:mau_masak/pages/home/home_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

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
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 25,
                    ))
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return StreamBuilder<QuerySnapshot>(
                stream: controller.getResep(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: List.generate(
                                  snapshot.data?.docs.length ?? 0, (index) {
                                return ResepCard(
                                  snap: snapshot.data?.docs[index].data(),
                                  controller: controller,
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                });
          }),
    );
  }

  Widget resepCard() {
    return Container();
  }
}

class ResepCard extends StatelessWidget {
  const ResepCard({required this.snap, required this.controller});
  final snap;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(PageName.detail, arguments: {"postId": snap['postId']});
      },
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
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(
                          "https://images.pexels.com/photos/3990301/pexels-photo-3990301.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Gerry",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
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
                            image: NetworkImage(snap['foto_resep']),
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
                                          snap['nama_resep'],
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
                                              "80 Menit",
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
                                  controller.likePost(snap['postId'],
                                      snap['uid'], snap['likes']);
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
                                        color:
                                            snap['likes'].contains(snap['uid'])
                                                ? Colors.red
                                                : Colors.white,
                                        size: 18,
                                      ),
                                      Text(
                                        "1",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 70,
                                height: 37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(27),
                                    color: primaryColor.withOpacity(0.5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      Icons.message_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    Text(
                                      "10",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )
                                  ],
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
