import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mau_masak/theme/styles.dart';

import '../../routes/page_names.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "AdminPanel",
              style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logout();
        },
        child: Icon(Icons.logout),
        backgroundColor: primaryColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(25),
        children: [
          CardButton(
            title: "Laporan Postingan",
            iconCard: Icons.post_add,
            ontap: () {
              Get.toNamed(PageName.laporanpostingan);
            },
          ),
          CardButton(
            title: "Laporan Komentar",
            iconCard: Icons.comment,
            ontap: () {
              Get.toNamed(PageName.laporankomentar);
            },
          ),
          CardButton(
            title: "Lihat Semua Pengguna",
            iconCard: Icons.person,
            ontap: () {
              Get.toNamed(PageName.listusers);
            },
          ),
          CardButton(
            title: "Lihat Semua Postingan",
            iconCard: Icons.book,
            ontap: () {
              Get.toNamed(PageName.listreseps);
            },
          )
        ],
      ),
    );
  }

  void logout() async {
    EasyLoading.show(status: 'loading...');
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(PageName.login);
    EasyLoading.dismiss();
  }
}

class CardButton extends StatelessWidget {
  String title;
  IconData iconCard;
  final Function() ontap;
  CardButton(
      {Key? key,
      required this.title,
      required this.iconCard,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: ontap,
        splashColor: primaryColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconCard,
                size: 70,
                color: primaryColor,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
