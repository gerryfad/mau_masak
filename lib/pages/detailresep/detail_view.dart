// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            CollectionReference users =
                FirebaseFirestore.instance.collection('resep');
            return FutureBuilder(
                future: users.doc(controller.postId).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        header(snapshot.data!['foto_resep']),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailInfo(snapshot, controller),
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
                                  snapshot.data!['deskripsi'],
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
                                      itemCount: snapshot.data!['bahan'].length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            snapshot.data!['bahan'][index],
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
                                      itemCount: snapshot.data!['step'].length,
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
                                                child: Text(snapshot
                                                    .data!['step'][index]),
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

  Widget detailInfo(
      AsyncSnapshot<DocumentSnapshot> snapshot, DetailController controller) {
    return Container(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot.data?['nama_resep'] ?? "",
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
                "19/11/2022  •",
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
                "${snapshot.data!['waktu']} Menit",
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
                          image: NetworkImage(
                              "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Gerry Fadlurahman",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.likePost(snapshot.data?['postId'],
                          snapshot.data?['uid'], snapshot.data?['likes']);
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
                            color: snapshot.data?['likes']
                                    .contains(snapshot.data?['uid'])
                                ? Colors.red
                                : Colors.white,
                            size: 17,
                          ),
                          Text(
                            snapshot.data!['likes'].length.toString(),
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
                        "postId": snapshot.data!['postId'],
                        "uid": snapshot.data!['uid'],
                        "name": snapshot.data!['username'],
                        "avatar": snapshot.data!['avatar']
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
