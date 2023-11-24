import 'package:get/get.dart';
import 'package:rk_admin/controller/home_controller.dart';
import 'package:rk_admin/controller/reminder_call_manager_controller.dart';



class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find(),Get.find()));
    Get.lazyPut(() => ReminderCallMAnagersController(Get.find(),Get.find()));
  }
}
