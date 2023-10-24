import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/call_details_controller.dart';
import 'package:rk_admin/controller/home_controller.dart';
import 'package:rk_admin/route/route.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';

class CallDetailsPage extends GetView<CallDetailsController> {
  const CallDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Call Details',Colors.white,20,FontWeight.bold),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      text("Caller name: ${HomeController.to.testimonialData.data![controller.i.toInt()].name!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Date: ${HomeController.to.testimonialData.data![controller.i.toInt()].date!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Call For: ${HomeController.to.testimonialData.data![controller.i.toInt()].callFor}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Company Name: ${HomeController.to.testimonialData.data![controller.i.toInt()].companyName!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("City: ${HomeController.to.testimonialData.data![controller.i.toInt()].city!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Mobile no: ${HomeController.to.testimonialData.data![controller.i.toInt()].mobileNo!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Reference By: ${HomeController.to.testimonialData.data![controller.i.toInt()].referanceBy!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Short brief: ${HomeController.to.testimonialData.data![controller.i.toInt()].shortBrief!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Our remarks: ${HomeController.to.testimonialData.data![controller.i.toInt()].ourRemarks!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                      text("Manager status: ${HomeController.to.testimonialData.data![controller.i.toInt()].managerStatus!}", Colors.black, 20, FontWeight.bold),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),

              whiteButton('Add New Call', (){Get.toNamed(AppRoute.addNewCall);}, 55, Get.width),
              SizedBox(height: 20,),
              text('History', Colors.white, 20, FontWeight.bold),
              SizedBox(height: 20,),
              Obx(() => controller.stateStatus.obs == StateStatus.SUCCESS.obs ?
              ListView.builder(
                  itemCount: controller.historyListData.data?.length,
                  shrinkWrap: true,
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              text("Date: ${controller.historyListData.data![index].date}", Colors.black, 20, FontWeight.bold),
                              SizedBox(height: 10,),
                              text("Next Date: ${controller.historyListData.data![index].nextDate}", Colors.black, 20, FontWeight.bold),
                              SizedBox(height: 10,),
                              text("Short Details: ${controller.historyListData.data![index].shortDetails}", Colors.black, 20, FontWeight.bold),
                              SizedBox(height: 10,),
                              text("Our Remarks: ${controller.historyListData.data![index].ourRemarks}", Colors.black, 20, FontWeight.bold),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  : controller.historyListData.data?.isEmpty == true && controller.stateStatus.obs == StateStatus.SUCCESS.obs ?
                  Center(
                    child: text('No Calls', Colors.white, 20, FontWeight.bold),
                  ) :
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
