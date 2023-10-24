
import 'package:get/get.dart';
import 'package:rk_admin/controller/login_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencie
    Get.lazyPut(() => LoginController(Get.find(), Get.find(), ));

  }

}