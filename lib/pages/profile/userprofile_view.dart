import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/model/user.dart' as model;
import 'package:mau_masak/pages/profile/userprofile_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          body: controller.isloading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Padding(
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
                                        backgroundImage: NetworkImage(
                                            user.profilePhoto ?? "")),
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
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              user.following?.length
                                                      .toString() ??
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
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              user.followers?.length
                                                      .toString() ??
                                                  "2",
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
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    // tombol follow
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: GFButton(
                                            onPressed: () {
                                              user.uid.contains(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                                  ? Get.toNamed(
                                                      PageName.editprofile)
                                                  : controller.followUser(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      user.uid);
                                            },
                                            text: user.uid.contains(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                ? "Edit Profil"
                                                : (user.followers ?? [])
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                    ? "Following"
                                                    : "Follow",
                                            shape: GFButtonShape.pills,
                                            splashColor: primaryColor,
                                            type: (user.followers ?? [])
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid)
                                                ? GFButtonType.outline
                                                : GFButtonType.solid,
                                            color: primaryColor,
                                            highlightColor: Colors.white,
                                            size: GFSize.LARGE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
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
                                  "postId": controller.resepData[index]
                                      ['postId'],
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
        );
      },
    );
  }
}
