import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/home_controller.dart';
import 'package:rk_admin/model/call_list_entity.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/route/route.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: text('Call Manager', Colors.white, 20, FontWeight.bold),
        backgroundColor: greybackColor,
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.reminderCallManagersPage);
              },
              icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                controller.logoutApiCall();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: greybackColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  whiteButton('Add New Call', () {
                    Get.toNamed(AppRoute.addCall);
                  }, 50, Get.width / 2.3),
                  whiteButton('Add Reminder', () {
                    Get.toNamed(AppRoute.addReminder);
                  }, 50, Get.width / 2.3),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DropdownButton(
                        isExpanded: true,
                        value: controller.selectedFilterCallValue.value == ''
                            ? controller.filterCallListMenu.value
                                .toSet()
                                .toList()[0]
                            : controller.selectedFilterCallValue.value,
                        onChanged: (value) {
                          controller.onSelectedFilterCallValue(value);
                        },
                        underline: const SizedBox(),
                        items: controller.filterCallListMenu.value
                            .toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'futur',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Select Call For",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              text('Old Calls', Colors.white, 18, FontWeight.w700),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.stateStatus.obs == StateStatus.SUCCESS.obs
                    ? controller.listAfterFilter.isEmpty == true &&
                            controller.stateStatus.obs ==
                                StateStatus.SUCCESS.obs
                        ? Center(
                            child: text('No Old Calls', Colors.white, 20,
                                FontWeight.bold),
                          )
                        : ListView.builder(
                            // itemCount: controller.testimonialData.data!.length,
                            itemCount: controller.listAfterFilter.length,
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              int i = index;
                              Datum item = controller.listAfterFilter[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoute.callDetails,
                                        arguments: [
                                          i,
                                          // controller.testimonialData.data![index].id
                                          item.id,
                                        ]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          text(item.name!, Colors.black, 20,
                                              FontWeight.bold),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          text(item.companyName!, Colors.black,
                                              20, FontWeight.bold),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          text(
                                              item.callFor.toString(),
                                              Colors.black,
                                              20,
                                              FontWeight.bold),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          text(item.date!, Colors.black, 20,
                                              FontWeight.bold),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ));
}
