import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/home_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';

class AddCallPage extends GetView<HomeController> {
  const AddCallPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: text('Call Manager', Colors.white, 20, FontWeight.bold),
        backgroundColor: greybackColor,
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: greybackColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.interviewKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                text('User:  ${controller.name}', Colors.white, 18,
                    FontWeight.normal),

                SizedBox(
                  height: 10,
                ),
                text('Date', Colors.white, 18, FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                Obx(() => GestureDetector(
                      onTap: () {
                        controller.selectDate(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 55,
                            width: Get.width / 1.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: greybackColor, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: text(controller.date.value, Colors.black,
                                  18, FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                text('Short Order', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.shortController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                text('Call for', Colors.white, 18, FontWeight.normal),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: controller.selectedCallFor.value == ''
                              ? controller.callForListRx.value
                                  .toSet()
                                  .toList()[0]
                              : controller.selectedCallFor.value,
                          onChanged: (newValue) {
                            controller.onSelectedApplyingFor(newValue);
                          },
                          underline: const SizedBox(),
                          items: controller.callForListRx.value
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
                                    //backgroundColor: Colors.grey.shade400
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Select Call For",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                text('Select Name & Mobile Number ', Colors.white, 18,
                    FontWeight.normal),
                // inputField(
                //   controller: controller.nameController,
                //   validation: controller.isEmptyValid,
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: controller.selectedContact.value,
                          onChanged: (Map<String, String>? newContact) {
                            controller.setSelectedContact(newContact);
                          },
                          items: controller.callLogList
                              .map<DropdownMenuItem<Map<String, String>>>(
                                  (callInfo) {
                            return DropdownMenuItem<Map<String, String>>(
                              value: callInfo,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  '${callInfo['name']} - ${callInfo['number']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'futur',
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                text('Company Name', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.companyController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                text('City', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.cityController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                // text('Mobile No.', Colors.white, 18, FontWeight.normal),
                // inputField(
                //   controller: controller.mobileController,
                //   validation: controller.isMobileValid,
                // ),
                SizedBox(
                  height: 10,
                ),
                text('Reference By', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.referenceController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                text('Short Brief', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.shortBriefController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                text('Remarks', Colors.white, 18, FontWeight.normal),
                inputField(
                  controller: controller.remarksController,
                  validation: controller.isEmptyValid,
                ),
                SizedBox(
                  height: 10,
                ),
                text('Status', Colors.white, 18, FontWeight.normal),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: controller.selectedStatus.value == ''
                              ? controller.statusListRx.value
                                  .toSet()
                                  .toList()[0]
                              : controller.selectedStatus.value,
                          onChanged: (newValue) {
                            controller.onSelectedStatus(newValue);
                          },
                          underline: const SizedBox(),
                          items: controller.statusListRx.value
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
                                    //backgroundColor: Colors.grey.shade400
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          hint: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Select Call For",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                text('Reminder Date & Time', Colors.white, 18,
                    FontWeight.normal),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.date_range),
                        hintText: 'Date',
                        border: InputBorder.none,
                      ),
                      controller: controller.dateController,
                      readOnly: true,
                      onTap: () async {
                        controller.chooseDate();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.date_range),
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
                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.center,
                  child: whiteButton('SUBMIT', () {
                    controller.editValidate();
                  }, 55, Get.width / 2),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ));
}
