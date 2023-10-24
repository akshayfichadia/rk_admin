
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/splash_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/resource/image.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';




class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Scaffold(
      backgroundColor: greybackColor,
      body: SafeArea(
        child: SlideTransition(
          position: controller.offsetAnimation,
          child: Stack(


            children: [
              Image.asset(splash,fit: BoxFit.fill,height: Get.height,width: Get.width,),

              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: Get.width/5,),
                    imageWidget(logoname,),
                    Spacer(),
                    // SizedBox(height: Get.width/1.1,),
                    imageWidget(flag),
                    SizedBox(height: 20,),
                  ],
                ),
              )

            ],
          ),
        ),
      ));
}
