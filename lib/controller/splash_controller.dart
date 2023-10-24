import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/resource/session_string.dart';
import 'package:rk_admin/route/route.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';


class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetStorageRepository _getStorageRepository;
  SplashController(this._getStorageRepository);

  late AnimationController _controller;
  late Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    _controller =
        AnimationController(duration: const Duration(seconds: 0), vsync: this);
    offsetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 0.0)).animate(
            CurvedAnimation(parent: _controller, curve: Curves.decelerate));
  }

  @override
  void onReady() {
    super.onReady();
    _launchPage();
  }

  _launchPage() async {
    //   bool _whereLogin =  _getStorageRepository.hasData(isLoginSession);
    await Future.delayed(const Duration(seconds: 2), () {});
    //  Get.toNamed(AppRoute.onBoard);
      bool _isLogin =
      _getStorageRepository.hasData(isLoginSession);

      if (_isLogin == false) {
        Get.offNamed(AppRoute.login);
      }else if (_isLogin == true) {
        Get.offNamed(AppRoute.home);
      } else{
        Get.offNamed(AppRoute.login);
      }
    // Get.offNamed(_whereLogin ? AppRoute.home : AppRoute.login);
    // if (_getStorageRepository.hasData(tokenSession)) {
    //   GlobalController.to.isLogin.value = true;
    // } else {
    //   GlobalController.to.isLogin.value = false;
    // }

    //Get.toNamed(AppRoute.home);
    // var userData = _getStorageRepository.getUserData();
    // if(userData?.token?.isNotEmpty == true) {
    //   Get.toNamed(AppRoute.home);
    // } else {
    //   Get.offNamed(AppRoute.login);
    // }
  }
}
