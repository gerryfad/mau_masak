import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/admin/dataresep/dataresep_controller.dart';
import 'package:mau_masak/routes/page_names.dart';
import 'package:mau_masak/theme/styles.dart';

class DataResepView extends StatelessWidget {
  const DataResepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "List Resep",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: GetBuilder<DataResepController>(
          init: DataResepController(),
          builder: (controller) {
            return StreamBuilder<QuerySnapshot>(
                stream: controller.getreseps(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  var resep = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: resep?.length ?? 0,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                PageName.detailresepadmin,
                                arguments: {
                                  "postId": resep![index]['postId'],
                                  "uid": resep[index]['uid'],
                                },
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      resep![index]['foto_resep'])),
                              title: Text(resep[index]['nama_resep']),
                              subtitle: Text(resep[index]['username']),
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
                                          controller.deleteResep(
                                              resep[index]['postId']);
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
                        ),
                      );
                    }),
                  );
                });
          }),
    );
  }
}
