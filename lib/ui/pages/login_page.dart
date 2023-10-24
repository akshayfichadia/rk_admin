import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/controller/login_controller.dart';
import 'package:rk_admin/resource/constant.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/resource/image.dart';
import 'package:rk_admin/ui/widget/all_widget.dart';


class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greybackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(logo),
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(login),
                  SizedBox(
                    height: 30,
                  ),
                  text('Login', Colors.white, 22, FontWeight.bold),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: inputField2(
                      controller: controller.mobileNumber,
                      validation: (value) {
                        if (value?.isEmpty == true) {
                          return "Please enter valid Email Address";
                        }
                      },
                      hintText: 'Email Address',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Obx(
                      () => inputField2(
                        obscureText:  !controller.passwordVisibal.value,
                          controller: controller.password,
                          validation: (value) {
                            if (value?.isEmpty == true) {
                              return "Please enter Password";
                            }
                          },
                          inkWell: InkWell(
                            child: Icon(
                              controller.passwordVisibal == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onTap: () {
                              controller.passwordVisibal.value =
                                  (!controller.passwordVisibal.value);
                            },
                          ),
                          hintText: 'Password'
                          //inkWell: Icon(Icons.remove_red_eye),

                          ),
                    ),
                  ),

                  SizedBox(
                    height: Get.width / 10,
                  ),
                  whiteButton('Login', () {
                    controller.loginApiCall();
                  }, 60, Get.width / 2.7),
                  SizedBox(
                    height: 30,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
