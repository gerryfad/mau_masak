import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mau_masak/pages/comment/comment_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/services/firemessaging_controller.dart';
import 'package:mau_masak/theme/styles.dart';

class CommentView extends StatelessWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
        init: CommentController(),
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
                "Komentar",
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: controller.getComment(),
              builder: (context, snapshot) {
                var komentar = snapshot.data?.docs;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: komentar?.length ?? 0,
                  itemBuilder: (context, index) => CommentCard(
                    snap: komentar?[index],
                    controller: controller,
                  ),
                );
              },
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                color: Colors.grey[100],
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          controller: controller.komentar,
                          decoration: const InputDecoration(
                            hintText: 'Ketikkan komentar',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.currentUserData['uid'] !=
                            controller.ownerUserData['uid']) {
                          FiremessagingController.activityPost(
                              controller.currentUserData['profilePhoto'],
                              controller.currentUserData['name'],
                              controller.ownerUserData['uid'],
                              'komentar',
                              controller.postId);
                          FiremessagingController.sendNotification(
                            controller.currentUserData['name'],
                            "Mengomentari Postingan Anda",
                            controller.ownerUserData['tokenNotif'],
                          );
                        }
                        controller.postComment(
                          controller.currentUserData['profilePhoto'],
                          controller.currentUserData['name'],
                          controller.currentUserData['uid'],
                        );
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: const Text(
                          'Komentar',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CommentCard extends StatelessWidget {
  var snap;
  CommentController? controller;
  CommentCard({Key? key, required this.snap, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(snap['profile_photo']),
              radius: 18,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${snap['username']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                          text: ' ${snap['text']}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        snap['created_at'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          controller!.currentUserData['uid'] != snap['uid']
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                Get.toNamed(PageName.laporpengguna,
                                    arguments: ({
                                      'postId': controller!.postId,
                                      'commentId': snap['commentId'],
                                      'terlapor': snap['username'],
                                      'terlaporId': snap['uid'],
                                      'pelapor':
                                          controller!.currentUserData['name'],
                                      'pelanggaran': snap['text'],
                                      'type': 'komentar'
                                    }));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: const Text("Laporkan Komentar"),
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.more_vert))
              : Container()
        ],
      ),
    );
  }
}
