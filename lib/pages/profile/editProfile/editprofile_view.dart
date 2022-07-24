// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mau_masak/pages/profile/editProfile/editprofile_controller.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:mau_masak/model/user.dart' as model;

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (controller) {
            return FutureBuilder<DocumentSnapshot>(
                future: controller.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    model.User user =
                        model.User.fromJson(snapshot.data as DocumentSnapshot);
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.pickImages();
                              },
                              child: Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                offset: Offset(0, 10))
                                          ],
                                          shape: BoxShape.circle,
                                          image: controller.images == null
                                              ? DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(user
                                                          .profilePhoto ??
                                                      "https://media.istockphoto.com/illustrations/blank-man-profile-head-icon-placeholder-illustration-id1298261537?k=20&m=1298261537&s=612x612&w=0&h=8plXnK6Ur3LGqG9s-Xt2ZZfKk6bI0IbzDZrNH9tr9Ok="),
                                                )
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(
                                                      controller.images!),
                                                )),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 4,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            color: Colors.green,
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            buildTextField("Username", user.username, false,
                                controller.username),
                            buildTextField("Password", "********", true,
                                controller.password),
                            SizedBox(
                              height: 35,
                            ),
                            GFButton(
                              onPressed: () async {
                                controller.updateUser();
                              },
                              text: "Simpan",
                              shape: GFButtonShape.pills,
                              fullWidthButton: true,
                              color: primaryColor,
                              size: GFSize.LARGE,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                });
          }),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPassword,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.black,
            )),
      ),
    );
  }
}
