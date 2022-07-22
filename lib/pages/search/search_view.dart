// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/search/search_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
              centerTitle: false,
              title: Container(
                height: 38,
                child: TextFormField(
                  onChanged: ((value) {
                    controller.changeSearch(value);
                  }),
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
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                      hintText: "Pencarian..."),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FlutterSwitch(
                    activeText: "User",
                    inactiveText: "Resep",
                    activeColor: primaryColor,
                    activeTextColor: Colors.white,
                    inactiveTextColor: Colors.white,
                    inactiveColor: primaryColor,
                    value: controller.togglesearch,
                    valueFontSize: 12.0,
                    width: 75,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (val) {
                      controller.changeToggleSearch(val);
                    },
                  ),
                ),
              ],
            ),
            body: StreamBuilder2<QuerySnapshot, QuerySnapshot>(
              streams: Tuple2(controller.getUser(), controller.getResep()),
              builder: (context, snapshot) {
                var user = snapshot.item1.data?.docs;
                var resep = snapshot.item2.data?.docs;
                if (snapshot.item1.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.search == "") {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: resep?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 1),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(PageName.detail,
                              arguments: {"postId": resep?[index]['postId']});
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Image.network(
                              resep?[index]['foto_resep'],
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  );
                }
                if (controller.togglesearch) {
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
                }
                return ListView.builder(
                  itemCount: resep?.length,
                  itemBuilder: (context, index) {
                    if ((resep?[index]['nama_resep'] ?? "")
                        .toString()
                        .toLowerCase()
                        .startsWith(controller.search.toLowerCase())) {
                      return ListTile(
                        onTap: () {
                          Get.toNamed(PageName.detail, arguments: {
                            "postId": resep?[index]['postId'],
                          });
                        },
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(resep?[index]
                                    ['foto_resep'] ??
                                "https://media.istockphoto.com/illustrations/blank-man-profile-head-icon-placeholder-illustration-id1298261537?k=20&m=1298261537&s=612x612&w=0&h=8plXnK6Ur3LGqG9s-Xt2ZZfKk6bI0IbzDZrNH9tr9Ok=")),
                        title: Text(
                          (resep?[index]['nama_resep']),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        });
  }
}
