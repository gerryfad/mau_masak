import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mau_masak/model/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/profile/myprofile_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Konfirmasi",
                          middleText: "Apakah Anda Yakin ingin keluar ?",
                          textConfirm: "Ya",
                          onConfirm: () {
                            controller.logout();
                          },
                          textCancel: "Tidak",
                          onCancel: () {
                            Get.back();
                          });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                    )),
              ),
            ],
          ),
          body: SmartRefresher(
            controller: controller.myProfileRefreshController,
            onRefresh: controller.onRefresh,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                        future: controller.getUserFuture(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            model.User user = model.User.fromJson(
                                snapshot.data as DocumentSnapshot);
                            return Column(
                              children: [
                                // profile photo
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(user
                                          .profilePhoto ??
                                      "https://firebasestorage.googleapis.com/v0/b/maumasak-ta.appspot.com/o/defaultphoto.jpeg?alt=media&token=dbc86119-76ec-4690-a0a5-e8c277d6aa06"),
                                ),

                                // username
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "@${user.username}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          controller.resepData.length
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          '  Post  ',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          user.following?.length.toString() ??
                                              "0",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Following',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          user.followers?.length.toString() ??
                                              "0",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Followers',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),

                    const SizedBox(height: 15),

                    // tombol edit profil
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: GFButton(
                            onPressed: () {
                              Get.toNamed(PageName.editprofile);
                            },
                            text: "Edit Profil",
                            shape: GFButtonShape.pills,
                            highlightColor: Colors.white,
                            splashColor: primaryColor,
                            color: primaryColor,
                            size: GFSize.LARGE,
                            type: GFButtonType.outline2x,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.resepData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(PageName.detail, arguments: {
                              "postId": controller.resepData[index]['postId'],
                              "uid": controller.resepData[index]['uid']
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.network(
                                controller.resepData[index]['foto_resep'],
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
