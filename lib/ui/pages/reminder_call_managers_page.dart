import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/reminder_call_manager_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReminderCallManagersPage extends GetView<ReminderCallMAnagersController> {
  const ReminderCallManagersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        title: text('Call Reminder', Colors.white, 20, FontWeight.bold),
        backgroundColor: greybackColor,
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.stateStatus.obs == StateStatus.SUCCESS.obs
                    ? controller.callReminderDataList.data!.isEmpty
                        ? Center(
                            child: text(
                              "No data Found",
                              Colors.white,
                              30,
                              FontWeight.bold,
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                controller.callReminderDataList.data!.length,
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var data =
                                  controller.callReminderDataList.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width/1.5,
                                              child: text(
                                                  data.callManagerName.toString(),
                                                  Colors.black,
                                                  20,
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            text(
                                                "Mobile No. : ${data.mobileNumber}",
                                                Colors.black,
                                                16,
                                                FontWeight.normal),
                                            const SizedBox(height: 10),
                                            text(
                                                "Date : ${data.nextReminderDate}",
                                                Colors.black,
                                                16,
                                                FontWeight.normal),
                                            const SizedBox(height: 10),
                                            text(
                                                "Time : ${data.nextReminderTime}",
                                                Colors.black,
                                                16,
                                                FontWeight.normal),
                                            const SizedBox(height: 10),
                                            text(
                                                "Notes : ${data.notes}",
                                                Colors.black,
                                                16,
                                                FontWeight.normal),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Visibility(
                                                  visible: data.type == "reminder_call" ?  true : false,
                                                  child: Icon(Icons.star,color: Colors.amber,)),
                                                SizedBox(height: 15,),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Uri phoneno = Uri.parse(
                                                        'tel:${data.mobileNumber}');
                                                    if (await launchUrl(phoneno)) {
                                                      //dialer opened
                                                    } else {
                                                      //dailer is not opened
                                                    }
                                                  },
                                                  child:   Icon(
                                                    Icons.call,
                                                    size: 25,color:  greybackColor
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                GestureDetector(
                                                  onTap: () {
                                                    String callManagerId =
                                                        data.id.toString();
                                                    String callManagerType =
                                                        data.type.toString();
                                                    controller
                                                        .getReminderCallManagerCompleteApi(
                                                      callManagerId,
                                                      callManagerType,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    size: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
