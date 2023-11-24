import 'package:get/get.dart';
import 'package:rk_admin/controller/edit_reminder_call_controller.dart';

class EditReminderCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditReminderCallController(Get.find(), Get.find()));
  }
}
