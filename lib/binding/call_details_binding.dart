import 'package:get/get.dart';
import 'package:rk_admin/controller/call_details_controller.dart';




class CallDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallDetailsController(Get.find(),Get.find()));

  }
}
