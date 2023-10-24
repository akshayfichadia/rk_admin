import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/call_details_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';


class AddHistoryCall extends GetView<CallDetailsController> {
  const AddHistoryCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Add Call',Colors.white,20,FontWeight.bold),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: false,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.interviewKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('Date : ${controller.todayDate.toString()}', Colors.white, 18, FontWeight.normal),
                SizedBox(height: 20,),
                text('Next Date', Colors.white, 18, FontWeight.normal),
                SizedBox(height: 20,),
                Obx(() => GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 55,
                        width: Get.width/1.15 ,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border:
                          Border.all(color: greybackColor, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: text(controller.date.value, Colors.black, 18, FontWeight.normal),

                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 20,),
                text('Short Details', Colors.white, 18, FontWeight.normal),
                SizedBox(height: 20,),
                inputField(
                  hintText: 'Short Details',
                  controller: controller.shortDetailsController,
                  validation: controller.isEmptyValid
                ),

                SizedBox(height: 20,),
                text('Remarks', Colors.white, 18, FontWeight.normal),
                SizedBox(height: 20,),
                inputField(
                    hintText: 'Remarks',
                    controller: controller.remarksController,
                    validation: controller.isEmptyValid
                ),
                SizedBox(height: 40,),


                whiteButton('Submit', (){controller.editValidate();}, 55, Get.width)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
