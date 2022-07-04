// ignore_for_file: prefer_const_constructors

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/addresep/addresep_view.dart';
import 'package:mau_masak/pages/dashboard/dashboard_controller.dart';

import 'package:mau_masak/pages/home/home_view.dart';
import 'package:mau_masak/pages/profile/myprofile_view.dart';
import 'package:mau_masak/pages/search/search_view.dart';
import 'package:mau_masak/routes/page_names.dart';

import 'package:mau_masak/theme/styles.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeView(),
                SearchView(),
                Container(),
                HomeView(),
                MyProfileView(),
              ],
            ),
          ),
          bottomNavigationBar: CupertinoTabBar(
            height: 55,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color:
                      (controller.tabIndex == 0) ? primaryColor : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color:
                      (controller.tabIndex == 1) ? primaryColor : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Get.toNamed(PageName.addresep);
                  },
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color:
                      (controller.tabIndex == 3) ? primaryColor : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color:
                      (controller.tabIndex == 4) ? primaryColor : Colors.grey,
                ),
              ),
            ],
            onTap: (index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex,
          ));
    });
  }
}
