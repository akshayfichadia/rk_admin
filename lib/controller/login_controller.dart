import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/session_string.dart';
import 'package:rk_admin/route/route.dart';
import 'package:rk_admin/shared/network_info.dart';


import '../../model/login_response_entity.dart';
import '../../resource/api_collection.dart';

import '../../shared/api_repository.dart';
import '../../shared/common/state_status.dart';
import '../../shared/get_storage_repository.dart';


class LoginController extends GetxController {
  final ApiRepository _apiRepository;
  final GetStorageRepository getStorageRepository;
 // final NetworkInfo _networkInfo;
  RxBool passwordVisibal = RxBool(false);

  LoginController(
      this._apiRepository, this.getStorageRepository,);

  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  final _loginDataRx = Rx<LoginEntity>(LoginEntity());
  LoginEntity get userData => _loginDataRx.value;

  // void clearFields() {
  //   mobileNumber.dispose();
  //   password.dispose();
  // }


  void loginApiCall() {
    // _networkInfo.isConnected().then((value) async {
    //   if (value) {
        _stateStatusRx.value = StateStatus.LOADING;
        // if (!fieldValidation()) {
        //  _stateStatusRx.value = StateStatus.INITIAL;
        //   return;
        // }
        _apiRepository.postApi(loginApi, queryParameters: {
          "email": mobileNumber.text.toString(),
          "password": password.text.toString()
        }, headers: {
          'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ'
        }, success: (response) async {
          _stateStatusRx.value = StateStatus.SUCCESS;
           _loginDataRx.value = LoginEntity.fromJson(response);

          await getStorageRepository.write(isLoginSession, true);
          await getStorageRepository.write(userNameSession, userData.data!.name);
          await getStorageRepository.write(userIdSession, userData.data!.id);
          await getStorageRepository.write(emailSession, userData.data!.email);
           Get.offNamed(AppRoute.home);

        }, error: (e) {
          _stateStatusRx.value = StateStatus.FAILURE;
          Get.showErrorSnackbar(e!.message);
        });
    //   } else {
    //     Get.showErrorSnackbar('No internet connect');
    //   }
    // });
  }





  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }
}
