// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/admin/pengguna/datausers_controller.dart';
import 'package:mau_masak/theme/styles.dart';

class DataUsersView extends StatelessWidget {
  const DataUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "List Users",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: GetBuilder<DataUsersController>(
          init: DataUsersController(),
          builder: (controller) {
            return StreamBuilder<QuerySnapshot>(
                stream: controller.getusers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  var users = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: users?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: (users![index]['name'])
                                  .toString()
                                  .startsWith('admin')
                              ? Container()
                              : ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          users[index]['profilePhoto'])),
                                  title: Text(users[index]['name']),
                                  subtitle: Text(users[index]['email']),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: "Konfirmasi",
                                            middleText: "Apakah Anda Yakin ?",
                                            textConfirm: "Ya",
                                            buttonColor: Colors.red,
                                            confirmTextColor: Colors.white,
                                            cancelTextColor: Colors.black,
                                            onConfirm: () {
                                              controller.suspendAkun(
                                                  users[index]['uid']);
                                            },
                                            textCancel: "Tidak",
                                            onCancel: () {});
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[700],
                                      )),
                                ),
                        ),
                      );
                    }),
                  );
                });
          }),
    );
  }
}
