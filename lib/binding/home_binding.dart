import 'package:get/get.dart';
import 'package:rk_admin/controller/home_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find(),Get.find()));

  }
}
