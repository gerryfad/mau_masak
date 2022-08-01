import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mau_masak/pages/activity/activity_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Aktivitas",
            style: TextStyle(color: Colors.black87, fontSize: 18)),
        elevation: 0,
      ),
      body: GetBuilder<ActivityController>(
          init: ActivityController(),
          builder: (controller) {
            return StreamBuilder<QuerySnapshot>(
              stream: controller.getActivity(),
              builder: (context, snapshot) {
                var activity = snapshot.data?.docs;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: activity?.length ?? 0,
                  itemBuilder: (contex, index) => ActivityCard(
                    snap: snapshot.data!.docs[index],
                  ),
                );
              },
            );
          }),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final snap;
  const ActivityCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Get.toNamed(
          PageName.detail,
          arguments: {
            "postId": snap['postId'],
            "uid": snap['uid'],
          },
        );
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(snap['profilePhoto']),
              radius: 18,
            ),
            Padding(
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
                          text: snap['type'] == 'komentar'
                              ? ' Mengomentari postingan anda'
                              : ' Menyukai postingan anda',
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
          ],
        ),
      ),
    );
  }
}
