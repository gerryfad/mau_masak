import 'package:get/get.dart';
import 'package:mau_masak/pages/addresep/addresep_controller.dart';

class AddresepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddresepController>(() => AddresepController());
  }
}
