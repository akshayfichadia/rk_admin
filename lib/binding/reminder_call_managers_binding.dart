import 'package:get/get.dart';

import 'package:rk_admin/controller/reminder_call_manager_controller.dart';

class ReminderCallManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReminderCallMAnagersController(Get.find(), Get.find()));
  }
}
