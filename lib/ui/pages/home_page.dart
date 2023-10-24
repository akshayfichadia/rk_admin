
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/home_controller.dart';
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
        title: text('Call Manager',Colors.white,20,FontWeight.bold),
        backgroundColor: greybackColor,
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            controller.LogOut();
         }, icon: Icon(Icons.logout))
        ],
      ),
      backgroundColor: greybackColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              whiteButton('Add New Call', (){Get.toNamed(AppRoute.addCall);}, 55, Get.width),
              SizedBox(height: 20,),
              text('Old Calls', Colors.white, 18, FontWeight.w700),
              SizedBox(height: 20,),
              Obx(() => controller.stateStatus.obs == StateStatus.SUCCESS.obs ?
              ListView.builder(
                  itemCount: controller.testimonialData.data!.length,
                  shrinkWrap: true,
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    int i = index;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: (){
                          Get.toNamed(AppRoute.callDetails,arguments: [i,controller.testimonialData.data![index].id]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(controller.testimonialData.data![index].name!, Colors.black, 20, FontWeight.bold),
                                SizedBox(height: 10,),
                                text(controller.testimonialData.data![index].companyName!, Colors.black, 20, FontWeight.bold),
                                SizedBox(height: 10,),
                                text(controller.testimonialData.data![index].callFor.toString()!, Colors.black, 20, FontWeight.bold),
                                SizedBox(height: 10,),
                                text(controller.testimonialData.data![index].date!, Colors.black, 20, FontWeight.bold),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  :
                  Center(
                    child: CircularProgressIndicator(),
                  )

              ),

              SizedBox(height: 20,),
            ],
          ),
        ),
      )
  );
}
