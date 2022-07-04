// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mau_masak/model/resep.dart';
import 'package:mau_masak/pages/detailresep/detail_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DetailController>(
          init: DetailController(),
          builder: (controller) {
            return FutureBuilder<DocumentSnapshot>(
                future: controller.getDetailResep(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Resep resep =
                        Resep.fromJson(snapshot.data as DocumentSnapshot);
                    return CustomScrollView(
                      slivers: [
                        header(resep.fotoResep ?? ""),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailInfo(resep, controller),
                                Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: textColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  resep.deskripsi ?? "",
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 15),
                                Divider(
                                  thickness: 1.5,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Bahan-Bahan",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: textColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  removeBottom: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: resep.bahan?.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            resep.bahan?[index],
                                          ),
                                        );
                                      })),
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  thickness: 1.5,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Langkah-langkah",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: textColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  removeBottom: true,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: resep.step?.length,
                                      itemBuilder: ((context, index) {
                                        return TimelineTile(
                                          alignment: TimelineAlign.manual,
                                          lineXY: 0.02,
                                          isFirst: index == 0,
                                          endChild: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(resep.step?[index]),
                                              ),
                                              Divider(
                                                thickness: 2,
                                              ),
                                            ],
                                          ),
                                          indicatorStyle: IndicatorStyle(
                                            width: 30,
                                            height: 30,
                                            indicator: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.fromBorderSide(
                                                  BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            drawGap: true,
                                          ),
                                          beforeLineStyle: LineStyle(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        );
                                      })),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          }),
    );
  }

  Widget header(
    String fotoResep,
  ) {
    return SliverAppBar(
      backgroundColor: primaryColor,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Image(
              image: NetworkImage(fotoResep),
              width: double.maxFinite,
              fit: BoxFit.cover,
              height: Get.height,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                height: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailInfo(Resep resep, DetailController controller) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            resep.namaResep ?? "",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                "${DateFormat.yMMMd().format(
                  resep.createdAt ?? DateTime.now(),
                )}  •",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: textColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.alarm,
                color: Colors.grey,
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${resep.waktu} Menit",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: textColor,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          //SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(resep.profilePhoto ??
                              "https://media.istockphoto.com/illustrations/blank-man-profile-head-icon-placeholder-illustration-id1298261537?k=20&m=1298261537&s=612x612&w=0&h=8plXnK6Ur3LGqG9s-Xt2ZZfKk6bI0IbzDZrNH9tr9Ok="),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.toNamed(PageName.userprofile, arguments: {
                        "uid": resep.uid,
                      });
                    },
                    child: Text(
                      resep.username ?? "",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.likePost(resep.postId ?? "", resep.uid ?? "",
                          resep.likes ?? []);
                    },
                    child: Container(
                      width: 70,
                      height: 27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          color: primaryColor.withOpacity(0.7)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: (resep.likes ?? []).contains(resep.uid)
                                ? Colors.red
                                : Colors.white,
                            size: 17,
                          ),
                          Text(
                            resep.likes?.length.toString() ?? "0",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(PageName.comment, arguments: {
                        "postId": resep.postId,
                        "uid": resep.uid,
                        "name": resep.username,
                        "avatar": resep.profilePhoto
                      });
                    },
                    child: Container(
                      width: 90,
                      height: 27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27),
                          color: primaryColor.withOpacity(0.7)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 17,
                          ),
                          Text(
                            "Komentar",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
