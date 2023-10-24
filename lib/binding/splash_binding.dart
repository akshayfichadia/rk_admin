import 'package:get/get.dart';
import 'package:rk_admin/controller/splash_controller.dart';



class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find()));

  }
}
