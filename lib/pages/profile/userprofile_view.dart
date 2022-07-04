import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/profile/myprofile_controller.dart';
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
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                    )),
              ),
            ],
          ),
          body: controller.isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Center(),
                        // profile photo
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(controller
                                  .userData['profilePhoto'] ??
                              "https://media.istockphoto.com/illustrations/blank-man-profile-head-icon-placeholder-illustration-id1298261537?k=20&m=1298261537&s=612x612&w=0&h=8plXnK6Ur3LGqG9s-Xt2ZZfKk6bI0IbzDZrNH9tr9Ok="),
                        ),

                        // username
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "@${controller.userData['name']}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: const [
                                    Text(
                                      '37',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text(
                                    '8',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: const [
                                    Text(
                                      '56',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '  Likes  ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // tombol follow
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: GFButton(
                                onPressed: () {
                                  controller.userData['uid'].contains(
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Get.toNamed(PageName.editprofile)
                                      : controller.followUser(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          controller.userData['uid']);
                                },
                                text: controller.userData['uid'].contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? "Edit Profil"
                                    : controller.userData['followers'].contains(
                                            FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? "Following"
                                        : "Follow",
                                shape: GFButtonShape.pills,
                                splashColor: primaryColor,
                                type: controller.userData['followers'].contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? GFButtonType.outline2x
                                    : GFButtonType.solid,
                                color: primaryColor,
                                size: GFSize.LARGE,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.resepData.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(
                                    controller.resepData[index]['foto_resep'],
                                    fit: BoxFit.cover,
                                  ));
                            }),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
