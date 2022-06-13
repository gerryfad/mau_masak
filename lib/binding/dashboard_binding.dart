import 'package:get/get.dart';
import 'package:mau_masak/pages/addresep/addresep_controller.dart';
import 'package:mau_masak/pages/dashboard/dashboard_controller.dart';
import 'package:mau_masak/pages/profile/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AddresepController>(() => AddresepController());
  }
}
