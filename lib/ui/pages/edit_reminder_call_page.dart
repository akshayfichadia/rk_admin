import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/edit_reminder_call_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';

class EditReminderCallPage extends GetView<EditReminderCallController> {
  const EditReminderCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:
                text('Edit Call Reminder', Colors.white, 20, FontWeight.bold),
            backgroundColor: greybackColor,
            centerTitle: false,
            elevation: 0),
        backgroundColor: greybackColor,
        body: Obx(
          () => Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text("Name", Colors.white, 18, FontWeight.normal),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Container(
                            width: Get.width,
                            height: 48,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Text(controller
                                .reminderCallData.callManagerName
                                .toString()),
                          ),
                        ),
                        text('Mobile Number', Colors.white, 18,
                            FontWeight.normal),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Container(
                            width: Get.width,
                            height: 48,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Text(
                              controller.reminderCallData.mobileNumber
                                  .toString(),
                            ),
                          ),
                        ),
                        text('Reminder Date & Time', Colors.white, 18,
                            FontWeight.normal),
                        SizedBox(height: 15),
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.selectReminderDate(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 55,
                                    width: Get.width / 1.12,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: greybackColor, width: 1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(
                                              controller.reminderDate.value,
                                              Colors.black,
                                              18,
                                              FontWeight.normal),
                                          Icon(Icons.calendar_today_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.timer_outlined),
                                hintText: 'Time',
                                border: InputBorder.none,
                              ),
                              controller: controller.timeController,
                              readOnly: true,
                              onTap: () async {
                                controller.chooseTime();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        text('Notes', Colors.white, 18, FontWeight.normal),
                        SizedBox(height: 15),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Notes', border: InputBorder.none),
                              controller: controller.notesController,
                              validator: controller.isFieldValid,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.center,
                          child: whiteButton('SUBMIT', () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.editReminderApiCall();
                            }
                          }, 45, Get.width / 2.5),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: controller.stateStatus == StateStatus.LOADING
                        ? true
                        : false,
                    child: Center(child: CircularProgressIndicator()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
