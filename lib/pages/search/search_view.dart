// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/search/search_controller.dart';
import 'package:mau_masak/routes/page_names.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Container(
                  height: 38,
                  child: TextFormField(
                    onChanged: ((value) {
                      controller.changeSearch(value);
                    }),
                    autofocus: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[650],
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                            fontSize: 14, color: Colors.grey.shade500),
                        hintText: "Search users"),
                  ),
                ),
              ),
              body: StreamBuilder<QuerySnapshot>(
                  stream: controller.getUser(),
                  builder: (context, snapshot) {
                    var user = snapshot.data?.docs;
                    if (controller.search == "") {
                      return const Center(
                        child: Text("Cari User"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: user?.length,
                      itemBuilder: (context, index) {
                        if ((user?[index]['name'] ?? "")
                            .toString()
                            .toLowerCase()
                            .startsWith(controller.search.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Get.toNamed(PageName.userprofile, arguments: {
                                "uid": user?[index]['uid'],
                              });
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(user?[index]
                                        ['profilePhoto'] ??
                                    "https://media.istockphoto.com/illustrations/blank-man-profile-head-icon-placeholder-illustration-id1298261537?k=20&m=1298261537&s=612x612&w=0&h=8plXnK6Ur3LGqG9s-Xt2ZZfKk6bI0IbzDZrNH9tr9Ok=")),
                            title: Text(
                              (user?[index]['name']),
                            ),
                          );
                        }
                        return Container();
                      },
                    );
                  }));
        });
  }
}
