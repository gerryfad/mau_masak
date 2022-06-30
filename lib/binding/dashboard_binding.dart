import 'package:get/get.dart';
import 'package:mau_masak/pages/addresep/addresep_controller.dart';
import 'package:mau_masak/pages/dashboard/dashboard_controller.dart';
import 'package:mau_masak/pages/home/home_controller.dart';
import 'package:mau_masak/pages/profile/profile_controller.dart';
import 'package:mau_masak/pages/search/search_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
