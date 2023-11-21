
import 'package:get/get.dart';
import 'package:rk_admin/controller/add_reminder_controller.dart';

class AddReminderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddReminderController(Get.find(),Get.find()));
  }
}