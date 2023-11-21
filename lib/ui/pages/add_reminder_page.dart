import 'package:contacts_service/contacts_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/add_reminder_controller.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';

import '../../resource/constant.dart';

class AddReminderPage extends GetView<AddReminderController> {
  const AddReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: text('Add Call Reminder', Colors.white, 20, FontWeight.bold),
            backgroundColor: greybackColor,
            centerTitle: false,
            elevation: 0),
        backgroundColor: greybackColor,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('Select Name & Mobile Number ', Colors.white, 18,
                            FontWeight.normal),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Container(
                            width: Get.width,
                            height: 48,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: DropdownSearch<Contact>(
                                
                                  onChanged: (newContact) {
                                    controller.setSelectedContact(newContact);
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  itemAsString: (item) =>
                                      "${item.displayName} -  ${item.phones!.isNotEmpty ? item.phones!.first.value : ""}",
                                  dropdownButtonProps: DropdownButtonProps(
                                      padding: EdgeInsets.zero),
                                  popupProps: PopupProps.menu(
                                      fit: FlexFit.loose,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps(
                                        scrollPadding: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(5),
                                        decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 12),hintText: "Search",border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)))
                                      )),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                hintText: "Select contact",
                                    border: InputBorder.none,
                                  )),
                                  validator: controller.isContactSelected,
                                  items: controller.contactList
                                  //   .map<DropdownMenuItem<Contact>>((callInfo) {
                                  // return DropdownMenuItem<Contact>(
                                  //   value: callInfo,
                                  //   alignment: AlignmentDirectional.centerStart,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(left: 10),
                                  //     child: Text(
                                  //         '${callInfo.displayName} - ${callInfo.phones!.first.value}',
                                  //         style: const TextStyle(
                                  //             color: Colors.black,
                                  //             fontFamily: 'futur')),
                                  //   ),
                                  // );
                                  //}).toList(),
                                  ),
                            ),
                          ),
                        ),
                        text('Reminder Date & Time', Colors.white, 18,
                            FontWeight.normal),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.date_range),
                                hintText: 'Date',
                                border: InputBorder.none,
                              ),
                              controller: controller.dateController,
                              readOnly: true,
                              validator: controller.isFieldValid,
                              onTap: () async {
                                controller.chooseDate();
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Center(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.date_range),
                                  hintText: 'Time',
                                  border: InputBorder.none),
                              controller: controller.timeController,
                              readOnly: true,
                              validator: controller.isFieldValid,
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
                              controller.addReminder();
                            }
                            //controller.editValidate();
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
