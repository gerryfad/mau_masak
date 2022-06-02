import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mau_masak/pages/dashboard/dashboard_controller.dart';

import 'package:mau_masak/pages/home/home_screen.dart';

import 'package:mau_masak/theme/styles.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeView(),
                HomeView(),
                HomeView(),
                HomeView(),
                HomeView(),
              ],
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            initialActiveIndex: controller.tabIndex,
            onTap: (index) => controller.changeTabIndex(index),
            items: const [
              TabItem(icon: CupertinoIcons.home),
              TabItem(icon: CupertinoIcons.search),
              TabItem(icon: CupertinoIcons.plus),
              TabItem(icon: CupertinoIcons.bell),
              TabItem(icon: CupertinoIcons.person),
            ],
            backgroundColor: Colors.white,
            color: textSecondaryColor,
            activeColor: primaryColor,
            style: TabStyle.fixedCircle,
          ),
        );
      },
    );
  }
}
